# Dependencies
execSync= (require 'child_process').execSync

# Main
hours= 60*60*1000
backup= ->
  console.log (execSync 'npm run backup').toString()

  setTimeout backup,24*hours

# Boot
backup()
