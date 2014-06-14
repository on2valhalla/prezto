#
# Provides for easier use of 256 colors and effects.
#
# Authors:
#   P.C. Shyamshankar <sykora@lucentbeing.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

typeset -gA FX FG BG FP BP

FX=(
                                        none                         "\e[00m"
                                        normal                       "\e[22m"
  bold                      "\e[01m"    no-bold                      "\e[22m"
  faint                     "\e[02m"    no-faint                     "\e[22m"
  standout                  "\e[03m"    no-standout                  "\e[23m"
  underline                 "\e[04m"    no-underline                 "\e[24m"
  blink                     "\e[05m"    no-blink                     "\e[25m"
  fast-blink                "\e[06m"    no-fast-blink                "\e[25m"
  reverse                   "\e[07m"    no-reverse                   "\e[27m"
  conceal                   "\e[08m"    no-conceal                   "\e[28m"
  strikethrough             "\e[09m"    no-strikethrough             "\e[29m"
  gothic                    "\e[20m"    no-gothic                    "\e[22m"
  double-underline          "\e[21m"    no-double-underline          "\e[22m"
  proportional              "\e[26m"    no-proportional              "\e[50m"
  overline                  "\e[53m"    no-overline                  "\e[55m"

                                        no-border                    "\e[54m"
  border-rectangle          "\e[51m"    no-border-rectangle          "\e[54m"
  border-circle             "\e[52m"    no-border-circle             "\e[54m"

                                        no-ideogram-marking          "\e[65m"
  underline-or-right        "\e[60m"    no-underline-or-right        "\e[65m"
  double-underline-or-right "\e[61m"    no-double-underline-or-right "\e[65m"
  overline-or-left          "\e[62m"    no-overline-or-left          "\e[65m"
  double-overline-or-left   "\e[63m"    no-double-overline-or-left   "\e[65m"
  stress                    "\e[64m"    no-stress                    "\e[65m"

                                        font-default                 "\e[10m"
  font-first                "\e[11m"    no-font-first                "\e[10m"
  font-second               "\e[12m"    no-font-second               "\e[10m"
  font-third                "\e[13m"    no-font-third                "\e[10m"
  font-fourth               "\e[14m"    no-font-fourth               "\e[10m"
  font-fifth                "\e[15m"    no-font-fifth                "\e[10m"
  font-sixth                "\e[16m"    no-font-sixth                "\e[10m"
  font-seventh              "\e[17m"    no-font-seventh              "\e[10m"
  font-eigth                "\e[18m"    no-font-eigth                "\e[10m"
  font-ninth                "\e[19m"    no-font-ninth                "\e[10m"
)

# These can be used in the prompt, and correspond to Solarized color scheme
FP=(
    default    '%{%F{000}%}'
    black      '%{%F{016}%}'
    burgundy   '%{%F{052}%}'
    dk_red     '%{%F{088}%}'
    lt_red     '%{%F{160}%}'
    lt_purple  '%{%F{090}%}'
    purple     '%{%F{057}%}'
    dk_purple  '%{%F{017}%}'
    dk_green   '%{%F{022}%}'
    green      '%{%F{034}%}'
    lt_green   '%{%F{047}%}'
    dk_blue    '%{%F{021}%}'
    lt_blue    '%{%F{075}%}'
    lt_yellow  '%{%F{156}%}'
    dk_yellow  '%{%F{178}%}'
    brown      '%{%F{094}%}'
    pink       '%{%F{177}%}'
    hot_pink   '%{%F{165}%}'
    fuchsia    '%{%F{127}%}'
    orange     '%{%F{202}%}'
    dk_orange  '%{%F{009}%}'
    grey       '%{%F{240}%}'
    dk_grey    '%{%F{235}%}'
    n          '%{%f%}'
    b          '%{%B%}'
    nb         '%{%b%}'
    )

BP=(
    default    '%{%K{000}%}'
    black      '%{%K{016}%}'
    burgundy   '%{%K{052}%}'
    dk_red     '%{%K{088}%}'
    lt_red     '%{%K{160}%}'
    lt_purple  '%{%K{090}%}'
    purple     '%{%K{057}%}'
    dk_purple  '%{%K{017}%}'
    dk_green   '%{%K{022}%}'
    green      '%{%K{034}%}'
    lt_green   '%{%K{047}%}'
    dk_blue    '%{%K{021}%}'
    lt_blue    '%{%K{075}%}'
    lt_yellow  '%{%K{156}%}'
    dk_yellow  '%{%K{178}%}'
    brown      '%{%K{094}%}'
    pink       '%{%K{177}%}'
    hot_pink   '%{%K{165}%}'
    fuchsia    '%{%K{127}%}'
    orange     '%{%K{202}%}'
    dk_orange  '%{%K{009}%}'
    grey       '%{%K{240}%}'
    dk_grey    '%{%K{235}%}'
    n          '%{%k%}'
    )

FP[none]="$FP[n]"
BP[none]="$BP[n]"
FX[none]="$FX[none]"
FG[none]="$FX[none]"
BG[none]="$FX[none]"
colors=(black red green yellow blue magenta cyan white)
for color in {0..255}; do
  if (( $color >= 0 )) && (( $color < $#colors )); then
    index=$(( $color + 1 ))
    FG[$colors[$index]]="\e[38;5;${color}m"
    BG[$colors[$index]]="\e[48;5;${color}m"
    FP[$colors[$index]]="%{%F{${color}}%}"
    BP[$colors[$index]]="%{%K{${color}}%}"
  fi

  FG[$color]="\e[38;5;${color}m"
  BG[$color]="\e[48;5;${color}m"
  FP[$color]="%F{${color}}"
  BP[$color]="%K{${color}}"
done
unset color{s,} index


# Two functions to show colors on command line
ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

# Show all 256 colors with color number
function spectrum_ls() {
  spectrum ${(kv)FP}
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
  spectrum ${(kv)BP}
}

# Usage: spectrum [color escape code]
# ex: spectrum '%F' OR spectrum '%B'
function spectrum() {
  local txt_len=${(c)#ZSH_SPECTRUM_TEXT}
  local colors
  colors=(black red green yellow blue magenta cyan white)
  local pallete
  typeset -A pallete
  # print ${(kv)2}
  set -A pallete $@


  print -- "---- ANSI colors ----\t\t\t\t\t\t\t---- Bright ANSI Colors ----"
  # Granted this is a bit hacky, but to get the expanded length
  # Once the strings are resolved in the loop would require much more code inside the loop
  # it reserves space for the coded string below as follows:
  # 5=number,colon,space / 16=colorname / 6=tab
  local total_len=$(( txt_len + 5 + 16 + 6 ))
  local max_color=15
  local spacing=20
  local max_color=15
  local rows=7
  local cols=$(( $COLUMNS / total_len - 1 ))
  local block_size=$(( (rows + 1) * (cols + 1) ))
  local blocks=$(( max_color / block_size ))
  local block row col code
  for block in {0..$blocks}; do
    for row in {000..$rows}; do
      for col in {000..$cols}; do
        code=$(( row + ( rows + 1 ) * col + ( block * block_size ) ))
        if [[ $code -lt 8 ]]; then
          print -Pn -- "${(l:2::0::0:)code}: ${(r:15:: :: :)colors[$(( code + 1 ))]} $pallete[$code]$ZSH_SPECTRUM_TEXT$pallete[n]\t"
        elif [[ $code -lt 16 ]]; then
          print -Pn -- "${(l:2::0::0:)code}: bright ${(r:8:: :::)colors[$(( code - 7 ))]} $pallete[$code]$ZSH_SPECTRUM_TEXT$pallete[n]\t"
        else
          continue
        fi
      done
      print
    done
  done

  print -- "\n\n---- X-Term 256 ----"
  # 5=number,colon,space / 2=end spacing
  total_len=$(( txt_len + 5 + 2))
  max_color=231
  cols=$(( $COLUMNS / total_len - 1 ))
  cols=$(( cols <= 0 ? 0 : cols))
  # The colors are organized in descending blocks of 35
  rows=35
  block_size=$(( (rows + 1) * (cols + 1) ))
  blocks=$(( ( max_color - 16 ) % block_size == 0 ? ( max_color - 16 ) / block_size - 1 : ( max_color - 16 ) / block_size ))
  local flop=1
  # Basically this loop prints blocks of colored text in rows of 35 at a time
  # It reverses the order on every block so it looks nice
  for block in {0..$blocks}; do
    for row in {000..$rows}; do
      for col in {000..$cols}; do
        if [[ $((block % 2)) -ne 0 && $cols -lt 6 ]]; then
          code=$(( 16 - 1 + ( block_size * ( block + 1 ) ) + ( flop * ( row + ( rows + 1 ) * col ) ) ))
        else
          code=$(( 16 + row + ( rows + 1 ) * col + ( block * block_size ) ))
        fi

        if [[ $code -gt max_color ]]; then
          print -n "${(l:$total_len:: :: :)}"
        else
          print -Pn -- "${(l:3::0::0:)code}: $pallete[$code]$ZSH_SPECTRUM_TEXT$pallete[n]  "
        fi
      done
      print
    done
    if [[ $(( block_size * (block + 1) )) -gt $max_color ]]; then
      break
    fi
    (( flop = -1 * flop ))
  done


  print "\n\n---- 35 Shades of Grey ----"
  for code in {232..255}; do
    print -P -- "$code: $pallete[$code]$ZSH_SPECTRUM_TEXT$pallete[n]"
  done

  print -- '\n\n---- Named Colors ($FP[name]) ----'
  for key in ${(k)FP}; do
    if [[ ${(c)#key} -gt 3 ]]; then
      print -P -- "${(r:15:: :: :)key} $pallete[$key]$ZSH_SPECTRUM_TEXT$pallete[n]\t"
    fi
  done
}


