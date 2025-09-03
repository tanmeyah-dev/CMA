#!/bin/bash

# Script to replace FadeIn and SlideFrom animations with standard Flutter widgets
# This will systematically update all Dart files to remove dependency on custom animations

echo "Starting animation replacement process..."

# Function to replace animations in a file
replace_animations_in_file() {
    local file="$1"
    echo "Processing: $file"
    
    # Create a backup
    cp "$file" "$file.backup"
    
    # Replace FadeIn with a simple Opacity widget
    sed -i '' 's/FadeIn(/Opacity(\n      opacity: 1.0,\n      child: /g' "$file"
    
    # Remove SlideFrom parameters and close the FadeIn properly
    sed -i '' 's/from: SlideFrom\.[A-Z]*,//g' "$file"
    sed -i '' 's/delay: [0-9.]*,//g' "$file"
    
    # Close the Opacity widget properly
    sed -i '' 's/);\s*$/);\n    );/g' "$file"
    
    echo "  - Updated $file"
}

# Find all Dart files that contain FadeIn or SlideFrom
files=$(find lib -name "*.dart" -exec grep -l "FadeIn\|SlideFrom" {} \;)

# Process each file
for file in $files; do
    # Skip our own animation files
    if [[ "$file" != *"custom_animations.dart" && "$file" != *"simple_fade_in.dart" && "$file" != *"global_animations.dart" ]]; then
        replace_animations_in_file "$file"
    fi
done

echo "Animation replacement complete!"
echo "Note: This is a basic replacement. You may need to manually adjust some animations for better UX."


