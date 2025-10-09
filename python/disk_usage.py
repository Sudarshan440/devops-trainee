import shutil

def check_disk_usage(threshold=80):
    """Check disk usage and alert if above threshold."""
    total, used, free = shutil.disk_usage("/")
    percent_used = used / total * 100

    print(f"Disk Usage: {percent_used:.2f}%")

    if percent_used > threshold:
        print("Warning: Disk usage is high!")
    else:
        print("Disk usage is normal.")

# Example usage
check_disk_usage(75)
