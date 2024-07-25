# Smart CD

This script enhances the `cd` command, automatically creating missing directories in your path.

## Installation

1. **Copy the `smartcd` function** from `smartcd.sh` into your `~/.zshrc` or `~/.bashrc` file.
2. **Source your `.zshrc` or `~/.bashrc` file:**
   ```bash
   source ~/.zshrc 
   # or
   source ~/.bashrc
   ```

## Usage

Simply use `cd` as you normally would. Missing directories will be created automatically.

```bash
cd existing_directory        
cd projects/new_project/src  
cd -                         # Go to the previous directory
cd ~                         # Go to the home directory
```

## Need Help?

Type `smartcd --help` or `smartcd -h` for usage details.
