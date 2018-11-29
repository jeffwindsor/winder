function fish_prompt
  #==========================================================================
  set -l line_prompt  "⟩"
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄ "
  set -l dirty    "*"
  set -l none     "◦"

  set -l info_datetime
  if test "$theme_datetime" = 'long'
    set info_datetime (gdate)
  else
    set info_datetime (gdate +%H:%M:%S)
  end

  set -l info_path
  if test "$theme_path" = 'long'
    set info_path (pwd | sed "s:^$HOME:~:")
  else
    set info_path (prompt_pwd)
  end

  set -l info_git
  if git_is_repo

    set -l info_git_dirty
    if git_is_touched
      set info_git_dirty " " $dirty
    else
      set info_git_dirty " " (git_ahead $ahead $behind $diverged $none)
    end
    
    set info_git (git_branch_name) $info_git_dirty

  end

  #==========================================================================
  set -l input_prompt
  if test $status = 0
    set input_prompt (set_color normal) $line_prompt
  else 
    set input_prompt (set_color red --bold)  $line_prompt
  end

  #================================================================
  # PRINT PROMPT
  echo -e ''
  echo -e -n -s (set_color blue) $info_path " " (set_color green) $info_git " " (set_color 808080) $info_datetime (set_color normal) 
  echo -e ''
  echo -e -n -s $input_prompt (set_color normal) " "
  
end