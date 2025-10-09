import shutil

def check_disk_usage(threshold=80):
    """Check disk usage and alert if above threshold."""

    # Get total, used, and free space in bytes
    total, used, free = shutil.disk_usage("/")

    # Convert bytes → GB for readability
    total_gb = total / (1024 ** 3)
    used_gb = used / (1024 ** 3)
    free_gb = free / (1024 ** 3)

    # Calculate used percentage
    percent_used = (used / total) * 100

    print(f"Total Space: {total_gb:.2f} GB")
    print(f"Used Space: {used_gb:.2f} GB")
    print(f"Free Space: {free_gb:.2f} GB")
    print(f"Disk Usage: {percent_used:.2f}%")

    # Alert if usage is above threshold
    if percent_used > threshold:
        print(f"Warning: Disk usage above {threshold}%!")
    else:
        print("Disk usage is under control.")

# --- Main execution block ---
if __name__ == "__main__":
    try:
        # Take threshold input from user
        user_input = input("Enter threshold percentage (default 80): ")
        if user_input.strip() == "":
            threshold = 80
        else:
            threshold = int(user_input)
        
        check_disk_usage(threshold)

    except ValueError:
        print("Invalid input! Please enter a valid number.")
