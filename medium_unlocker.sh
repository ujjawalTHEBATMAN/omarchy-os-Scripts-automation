#!/bin/bash

echo "--- 🔴 DEBUG MODE STARTED ---"
echo "Waiting for copy..."

# We use 'cat' to read the text coming from the pipe
wl-paste --type text --watch bash -c '
    # 1. Capture Input
    content=$(cat)
    
    # 2. Define Targets
    target="medium.com"
    mirror="https://freedium-mirror.cfd/"

    # 3. DEBUG: Show exactly what we see (with brackets to spot hidden spaces)
    echo ""
    echo "---------------------------------------------------"
    echo "🔍 RAW CLIPBOARD: [$content]"

    # 4. DEBUG: Test the "IF" logic explicitly
    # We force it to print YES or NO so there is no guessing
    is_medium=$( [[ "$content" == *"$target"* ]] && echo "YES" || echo "NO" )
    is_freedium=$( [[ "$content" == *"$mirror"* ]] && echo "YES" || echo "NO" )

    echo "   -> Contains medium.com?   : $is_medium"
    echo "   -> Already freedium?      : $is_freedium"

    # 5. EXECUTE LOGIC
    if [[ "$is_medium" == "YES" ]]; then
        if [[ "$is_freedium" == "NO" ]]; then
            echo "   ✅ MATCH! Generating new link..."
            
            final_url="${mirror}${content}"
            echo "   🚀 OPENING: $final_url"
            
            xdg-open "$final_url"
        else
            echo "   ⚠️ IGNORE: Link is already converted."
        fi
    else
        echo "   ❌ IGNORE: Not a medium link."
    fi
'
