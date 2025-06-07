#!/bin/bash

# Function to validate if input is a number
is_number() {
    [[ $1 =~ ^[0-9]+$ ]]
}

# Function to generate multiplication table using list form loop
generate_list_loop() {
    local number=$1
    local start=$2
    local end=$3
    local order=$4

    echo -e "\nUsing List Form For Loop:"
    if [[ "$order" == "desc" ]]; then
        for i in $(seq $end -1 $start); do
            echo "$number x $i = $((number * i))"
        done
    else
        for i in $(seq $start $end); do
            echo "$number x $i = $((number * i))"
        done
    fi
}

# Function to generate multiplication table using C-style loop
generate_c_loop() {
    local number=$1
    local start=$2
    local end=$3
    local order=$4

    echo -e "\nUsing C-Style For Loop:"
    if [[ "$order" == "desc" ]]; then
        for (( i=end; i>=start; i-- )); do
            echo "$number x $i = $((number * i))"
        done
    else
        for (( i=start; i<=end; i++ )); do
            echo "$number x $i = $((number * i))"
        done
    fi
}

# --- Main Program Starts Here ---

# Prompt user to enter a number
read -p "Enter a number for the multiplication table: " num

# Validate input
if ! is_number "$num"; then
    echo "Invalid input. Please enter a positive number."
    exit 1
fi

# Ask for full or partial table
read -p "Do you want the full table (1-10) or partial? (full/partial): " choice

# Default start and end
start=1
end=10

if [[ "$choice" == "partial" ]]; then
    read -p "Enter start of range: " start
    read -p "Enter end of range: " end

    if ! is_number "$start" || ! is_number "$end" || (( start > end )); then
        echo "Invalid range. Defaulting to full table (1 to 10)."
        start=1
        end=10
    fi
fi

# Ask for order: ascending or descending
read -p "Display in ascending or descending order? (asc/desc): " order
if [[ "$order" != "desc" ]]; then
    order="asc"
fi

# Generate tables using both loop styles
generate_list_loop "$num" "$start" "$end" "$order"
generate_c_loop "$num" "$start" "$end" "$order"

# Bonus: Ask if user wants to try again
read -p "Would you like to generate another table? (yes/no): " repeat
if [[ "$repeat" == "yes" ]]; then
    echo -e "\nRestarting script...\n"
    exec "$0"  # Restart script
else
    echo "Goodbye!"
    exit 0
fi

