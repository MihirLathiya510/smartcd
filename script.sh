smartcd() {
  local folder_path="$1"
  local target_dir

  # Help Option
  if [[ "$folder_path" == "--help" || "$folder_path" == "-h" ]]; then
      echo "Usage: smartcd [OPTIONS] [DIRECTORY]"
      echo ""
      echo "Options:"
      echo "  -h, --help   Show this help message"
      echo "  -           Navigate to the previous working directory"
      echo ""
      echo "Arguments:"
      echo "  DIRECTORY    The path to the directory (absolute or relative)"
      echo ""
      echo "Examples:"
      echo "  smartcd my_project       # Create and enter 'my_project' if it doesn't exist"
      echo "  smartcd path/to/dir     # Navigate to the specified directory"
      echo "  smartcd -                # Go back to the previous directory"
      echo "  smartcd ~                # Go to the home directory"
      return 0 
  fi

  # Handle ~ (home directory) and -
  if [[ "$folder_path" == "~" || "$folder_path" == "" ]]; then
      target_dir="$HOME"
  elif [[ "$folder_path" == "-" ]]; then
      target_dir="$OLDPWD"
  else
      # Handle absolute and relative paths (no backslash conversion)
      if [[ "$folder_path" == /* ]]; then
          target_dir="$folder_path"
      else
          target_dir="$PWD/$folder_path"
      fi
  fi

  if [[ -f "$target_dir" ]]; then
      echo "Error: '$target_dir' is a file, not a directory." >&2
      return 1
  fi

  # Update OLDPWD before changing directories (but not when using "-")
  if [[ "$folder_path" != "-" ]]; then
      local current_dir="$PWD"
  fi

  builtin cd "$target_dir" 2>/dev/null || {
      echo "Path '$target_dir' not found. Creating and entering..."
      command mkdir -p "$target_dir" && builtin cd "$target_dir" || {
          echo "Failed to create or enter directory '$target_dir'." >&2
          return 1 
      }
  }

  # Only update OLDPWD if we successfully changed to a new directory and not using "-"
  if [[ "$current_dir" != "$PWD" && "$folder_path" != "-" ]]; then
      OLDPWD="$current_dir"
  fi
}