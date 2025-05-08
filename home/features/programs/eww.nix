{
  config,
  pkgs,
  ...
}: let
  # EWW can't directly launch programs
  launchPavucontrolScript = pkgs.writeShellScript "launch-pavucontrol" ''
    pavucontrol
  '';

  # WARN: Please see if you can actually make use of this script before copying it!
  gpuTempScript = pkgs.writeShellScript "eww-gputemp" ''
    gpuDir=$(grep -rl /sys/class/hwmon/hwmon*/name -e 'amdgpu' | xargs dirname)
    cat $gpuDir/temp*_input \
      | awk '{s+=$1}END{printf "%.0f", s/NR/1000}'
  '';

  updateHomeScript = pkgs.writeShellScript "eww-updatehome" ''
    eww update quickactionslabelcolor="blue"
    eww update quickactionslabel="[ UPDATING HOME ]"

    git -C ~/.nixos add -A

    if nh home switch ~/.nixos -- --max-jobs 3 > /tmp/home-update.log 2>&1;
    then
      notify-send "Home updated!"
    else
      # TODO: action that opens error in `bat` or `less` or something?
      notify-send "Home update failed. Find the log at /tmp/home-update.log" --urgency "CRITICAL"
    fi

    eww update quickactionslabel=""
  '';

  updateSystemScript = pkgs.writeShellScript "eww-updatesystem" ''
    eww update quickactionslabelcolor="pink"
    eww update quickactionslabel="[ UPDATING FLAKE ]"

    nix flake update --flake ~/.nixos

    eww update quickactionslabel="[ UPDATING SYSTEM ]"

    git -C ~/.nixos add -A

    if nh os switch ~/.nixos -- --max-jobs 3 > /tmp/system-update.log 2>&1;
    then
      notify-send "System updated!" --urgency "LOW"
    else
      notify-send "System update failed. Find the log at /tmp/system-update.log" --urgency "CRITICAL"
      eww update quickactionslabel=""
      exit -1
    fi

    exec ${updateHomeScript.outPath}
  '';

  changeVolumeScript = pkgs.writeShellScript "eww-changevolume" ''
    sink=$(pactl get-default-sink)
    currentvol=$(pactl get-sink-volume "$sink" | grep -oP '\d+(?=%)' | head -1)

    if [ "$1" == "up" ]; then
      if [ "$currentvol" -ge 150 ]; then
        newvol=150
      else
        newvol=$((currentvol + 5))
      fi
    else
      if [ "$currentvol" -le 25 ]; then
        newvol=25
      else
        newvol=$((currentvol - 5))
      fi
    fi

    pactl set-sink-volume "$sink" "''${newvol}%"

    eww poll volume # Update volume now rather than waiting for next poll
  '';

  # NOTE: stolen from https://github.com/elkowar/eww/issues/230#issuecomment-1560667894
  cavaScript = pkgs.writeShellScript "cava.sh" ''
    printf "[general]\n
      framerate=60\n
      bars = 14\n
      [output]\n
      method = raw\n
      raw_target = /dev/stdout\n
      data_format = ascii\n
      ascii_max_range = 7\n" \
    | ${pkgs.stable.cava}/bin/cava -p /dev/stdin \
    | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g; '
  '';

  getSwayWorkspaceInfo = pkgs.writeShellScript "getswayworkspaceinfo" ''
    swaymsg --raw --type get_workspaces \
      | jq ".[] | {num, representation}" \
      | sed 's/[]HV\[]//g' \
      | jq -s 'map({ num, windowCount: (.representation | split(" ") | length) })'
  '';

  getSwayFocusedWorkspace = pkgs.writeShellScript "getswayfocusedworkspace" ''
    swaymsg --type get_workspaces --pretty \
      | sed -n "s/Workspace \([0-9]\) (focused)/\1/p"
  '';

  mkWorkspaceLabel = workspaceNumber: extraClass: ''
    (label :class "widget ${extraClass} ''${swayworkspacefocused == ${workspaceNumber} ? 'focusedworkspace' : 'workspace'}" :text "[ ''${jq(swayworkspaceinfo, ".[] | select(.num==${workspaceNumber}) | .windowCount") ?: "0"} ]")
  '';
in {
  programs.eww.enable = true;

  home.file.".config/eww/eww.yuck".text = ''
    (defwindow main
      :monitor "DP-1"
      :stacking "fg"
      :exclusive true
      :geometry (geometry
        :width "100%"
        :height "20%"
        :anchor "top center")
      :namespace "background"
      (box :class "container" :orientation "horizontal" :space-evenly false
        (box :orientation "vertical" :space-evenly false
          (datetime)
          (quickactions)
          (powermenu)
          (mpris)
          (volumeslider))
        (box :orientation "vertical" :space-evenly false :hexpand true
          (box :vexpand true (swayworkspaces true))
          (box :class "widget" (ram_info)))
        (box :orientation "vertical" :space-evenly false
          (sys_info)
          (systray :class "widget tray" :vexpand true :icon-size 24))))

    (defwindow test_blank
      :monitor "DP-1"
      :stacking "overlay"
      :geometry (geometry
        :y "-30%"
        :width "70%"
        :height "20%"
        :anchor "top left")
      :namespace "widgets"
      (testbox))

    (defwidget background [] (box :class "background"))

    (defwidget testbox [] (box :class "widget testbox" :hexpand "true" :vexpand "true"))

    (defwidget quickactions []
      (stack :transition "slideright" :selected "''${quickactionslabel == "" ? 1 : 0}"
        (label :class "widget inactive ''${quickactionslabelcolour}" :text "''${quickactionslabel}")
        (box :orientation "horizontal"
          (eventbox :cursor "pointer"
            (button :timeout "10m" :class "widget button blue" :onclick "${updateHomeScript.outPath}" (label :text "NUH")))
          (eventbox :cursor "pointer"
            (button :timeout "10m" :class "widget button teal" :onclick "notify-send garbage" (label :text "NGC")))
          (eventbox :cursor "pointer"
            (button :timeout "10m" :class "widget button pink" :onclick "${updateSystemScript.outPath}" (label :text "NUS"))))))

    (defwidget powermenu []
      (stack :transition "slideright" :selected "''${powermenuindex}"
        (box :orientation "horizontal"
          (eventbox :cursor "pointer"
            :onclick "''${powermenufunction == "pwr" ? "poweroff" : powermenufunction == "rbt" ? "reboot" : "systemctl restart --system-firmware"}"
            :onhoverlost "eww update powermenuindex='1'"
            (label :class "widget red" :text "[ CNFRM ]"))
          (label :class "inactive" :text "UT ''${uptime}"))
        (box :orientation "horizontal"
          (eventbox :cursor "pointer"
            (button :class "widget button red" :onclick "eww update powermenufunction='pwr' powermenuindex='0'" (label :text "PWR")))
          (eventbox :cursor "pointer"
            (button :class "widget button yellow" :onclick "eww update powermenufunction='rbt' powermenuindex='0'" (label :text "RBT")))
          (eventbox :cursor "pointer"
            (button :class "widget button orange" :onclick "eww update powermenufunction='efi' powermenuindex='0'" (label :text "EFI"))))))

    (defwidget mpris []
      (box :class "widget mpris" :orientation "vertical" :vexpand true
        (stack :selected "''${mprisplayername == "" ? 0 : 1}"
          (label :class "inactive" :text "[ UNAVAILABLE ]")
          (box :orientation "vertical"
            (label :text "[ ''${mprisplayername == "firefox" ? "YT" : mprisplayername == "spotify" ? "SPT" : "UNK" } ] ''${mprisplaytime}")
            (stack :selected "''${mprisstatus == "PLAYING" ? 1 : 0}"
              (label :text "[ ''${mprisstatus?:"PAUSED"} ]")
              (box :orientation "horizontal" :space-evenly false
                (label :text "''${cava}")
                (button :class "widget button" :hexpand true :onclick "${pkgs.stable.playerctl}/bin/playerctl previous" (label :class "small-label" :text "󰒮"))
                (button :class "widget button" :hexpand true :onclick "${pkgs.stable.playerctl}/bin/playerctl play-pause" (label :class "small-label" :text "󰐎"))
                (button :class "widget button" :hexpand true :onclick "${pkgs.stable.playerctl}/bin/playerctl next" (label :class "small-label" :text "󰒭"))))))))

    (defwidget volumeslider []
      (box :class "widget" :orientation "horizontal" :space-evenly false
        (label :unindent false :text " VOL ")
        (eventbox :class "pink"
          :onscroll "${changeVolumeScript.outPath} {}"
          :onclick "${launchPavucontrolScript.outPath}"
          :onrightclick "${pkgs.stable.pamixer}/bin/pamixer --toggle-mute"
          (ascii_bar :value volume))))

    (defwidget swayworkspaces []
      (box :orientation "vertical"
        (box :orientation "horizontal"
          ${mkWorkspaceLabel "4" "pink"}
          ${mkWorkspaceLabel "5" "pink"}
          ${mkWorkspaceLabel "6" "pink"})
        (box :orientation "horizontal"
          ${mkWorkspaceLabel "1" "blue"}
          ${mkWorkspaceLabel "2" "pink"}
          ${mkWorkspaceLabel "3" "green"})))

    (defwidget sys_info []
      (box :class "widget" :orientation "vertical"
        (cpu_info)
        (gpu_info)))

    (defwidget cpu_info []
      (usagemeters :header "CPU" :label1 "LOAD" :value1 "''${round(EWW_CPU.avg, 0)}" :label2 "TEMP" :value2 "''${round(EWW_TEMPS.ACPITZ_TEMP1, 0)}"))

    (defwidget gpu_info []
      (usagemeters :header "GPU" :label1 "LOAD" :value1 "''${round(gpu_usage, 0)}" :label2 "TEMP" :value2 "''${round(gpu_temp, 0)}"))

    (defwidget ram_info []
      (usagemeters :header "MEMORY" :label1 " RAM" :value1 "''${round(EWW_RAM.used_mem_perc, 0)}" :label2 "VRAM" :value2 "''${round(vram_usage, 0)}"))

    (defwidget usagemeters [header label1 value1 label2 value2]
      (box :class "twin-meters" :orientation "vertical" :spacing 4
        (ascii_header :header "''${header}")
        (box :orientation "horizontal" :space-evenly "false"
          (label :unindent "false" :text " ''${label1} ")
          (ascii_bar :value value1 :noUsageCss false)
          (label :class "small-label" :unindent "false" :text "''${value1 >= 100 ? "!!" : strlength(value1) == 1 ? "0''${value1}" : "''${value1}"}"))
        (box :orientation "horizontal" :space-evenly "false"
          (label :unindent "false" :text " ''${label2} ")
          (ascii_bar :value value2 :noUsageCss false)
          (label :class "small-label" :unindent "false" :text "''${value2 >= 100 ? "!!" : strlength(value2) == 1 ? "0''${value2}" : "''${value2}"}"))))

    (defwidget ascii_bar [value ?noUsageCss]
      (label :class "ascii-bar ''${(noUsageCss?:true) ? "" : value >= 85 ? "veryhigh" : value > 45 ? "high" : "normal"}" :text "''${substring("████████████████████", 0, round((value + 4) / 5, 0))}''${substring("░░░░░░░░░░░░░░░░░░░░", round((value + 4) / 5, 0), 20)}"))

    (defwidget ascii_header [header]
      (label :class "ascii-header" :limit-width 28 :show-truncated "false" :text "====[ ''${header} ]========================="))

    (defwidget datetime []
      (label :class "widget datetime red" :text "''${datetime}"))

    (defwidget inactive []
      (label :class "inactive" :text "[ MODULE INACTIVE ]"))

    (defvar quickactionslabel "")
    (defvar quickactionslabelcolour "")
    (defvar powermenuindex 1)
    (defvar powermenufunction "")

    (defpoll datetime :interval "1s" `date "+%a %d %b %Y | %H:%M:%S"`)

    (defpoll gpu_usage :interval "2s" `cat /sys/class/hwmon/hwmon*/device/gpu_busy_percent`)

    (defpoll gpu_temp :interval "2s" `${gpuTempScript.outPath}`)

    (defpoll vram_usage :interval "2s" `cat /sys/class/hwmon/hwmon*/device/mem_busy_percent`)

    (defpoll volume :interval "5s" `${pkgs.stable.pamixer}/bin/pamixer --get-volume`)

    (defpoll uptime :interval "1s" `awk '{uptime=$1; hours=int(uptime/3600); minutes=int((uptime%3600)/60); seconds=uptime%60; printf "%02d:%02d:%02d\n", hours, minutes, seconds}' /proc/uptime`)

    (defpoll swayworkspaceinfo :interval "1s" `${getSwayWorkspaceInfo.outPath}`)

    (defpoll swayworkspacefocused :interval "2s" `${getSwayFocusedWorkspace.outPath}`)

    (deflisten mprisplayername :initial "" `${pkgs.stable.playerctl}/bin/playerctl metadata --follow --format "{{playerName}}"`)

    (deflisten mprisstatus :initial "" `${pkgs.stable.playerctl}/bin/playerctl metadata --follow --format "{{uc(status)}}"`)

    (deflisten mprisplaytime :initial "" `${pkgs.stable.playerctl}/bin/playerctl metadata --follow --format "{{duration(position)}} / {{duration(mpris:length)}}"`)

    (deflisten cava :initial "" `${cavaScript.outPath}`)
  '';

  home.file.".config/eww/eww.scss".text = with config.lib.stylix.colors.withHashtag; ''
    * {
      all: unset;

      font-family: "${config.stylix.fonts.monospace.name}";
    }

    .container {
      background-color: ${base00};
      margin: 20px;
      margin-bottom: 0px;
      padding: 10px;
      border-radius: 10px;
    }

    .widget {
      background-color: ${base01};
      border-style: solid;
      border-radius: 8px;
      border-width: 2px;
      border-color: ${base02};
      margin: 5px;
      padding: 5px;
    }

    .testbox {
      background-color: ${base0F};
    }

    .volume-bar {
      color: ${base0F};
    }

    .button:hover {
      background-color: ${base02};
    }

    .datetime {
      padding-left: 10px;
      padding-right: 10px;
    }

    .inactive {
      color: ${base04};
    }

    .small-label {
      font-size: 0.7em;
      color: ${base04};
      margin-left: 4px;
    }

    .ascii-bar {
      border-style: solid;
      border-width: 1px;
      border-color: ${base04};
      padding: 4px;
    }

    .ascii-bar.normal {
      color: ${base0B};
    }

    .ascii-bar.high {
      color: ${base0A};
    }

    .ascii-bar.veryhigh {
      color: ${base08};
    }

    .tray menu {
      padding: 4px;
      background-color: ${base00};
      border-radius: 8px;

      >menuitem {
        padding: 0px 5px;

        &:disabled {
          color: ${base04};
        }

        &:hover {
          background-color: ${base01};
        }
      }

      separator {
        background-color: ${base03};
        padding-top: 2px;

        &:last-child {
          padding:unset;
        }
      }
    }

    .red {
      color: ${base08}
    }

    .orange {
      color: ${base09}
    }

    .yellow {
      color: ${base0A}
    }

    .green {
      color: ${base0B}
    }

    .teal {
      color: ${base0C}
    }

    .blue {
      color: ${base0D}
    }

    .pink {
      color: ${base0E}
    }
  '';
}
