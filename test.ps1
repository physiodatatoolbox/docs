# Script for testing the site using htmlproofer.
#
# If running ps1 scripts is disabled, copy paste this into the PowerShell terminal.
#
# https://www.supertechcrew.com/jekyll-check-for-broken-links/


# Build with special config:
echo "Building site."
bundle exec jekyll build --config "_config.yml,_config.localhost.yml"

# Serve files in background:
echo "Serving files"
$j = start-process -FilePath "bundle" -ArgumentList ("exec", "jekyll", "server", "--config", "_config.yml,_config.localhost.yml", "--skip-initial-build") -PassThru
Start-Sleep -s 10

# Note, external links seem to crash, but the following does not run:
#  bundle exec htmlproofer --allow-hash-href ./_site --empty_alt_ignore true --typhoeus_config '{"ssl_verifypeer":"False","ssl_verifyhost":0}'
# So, just ignore the 0-errors.
bundle exec htmlproofer --allow-hash-href ./_site --empty_alt_ignore true --http_status_ignore [0]



