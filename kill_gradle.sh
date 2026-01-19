#!/bin/bash
# Script to kill all Gradle daemons and remove lock files

echo "Stopping Gradle daemons..."
pkill -f gradle || echo "No Gradle processes found"

echo "Removing project Gradle cache..."
rm -rf android/.gradle

echo "Removing global Gradle wrapper locks..."
rm -rf ~/.gradle/wrapper/dists/gradle-8.7-all/*/gradle-8.7-all.zip.lck 2>/dev/null

echo "Removing Flutter Gradle locks..."
rm -rf ~/Downloads/flutter/packages/flutter_tools/gradle/.gradle 2>/dev/null

echo "Done! Try building again."





