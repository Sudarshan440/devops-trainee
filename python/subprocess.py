import subprocess

def check_disk_usage(threshold=80):
    """Check disk usage using subprocess (df command)."""
    # Run the df command and capture output
    result = subprocess.run(["df", "-h", "/"], capture_output=True, text=True)

    # Check if the command was successful
    if result.returncode != 0:
        print("Error: Failed to get disk usage.")
        print(result.stderr)
        return

    # Split the command output into lines
    lines = result.stdout.splitlines()
    # Example output: ['Filesystem Size Used Avail Use% Mounted on', '/dev/sda1 100G 70G 30G 70% /']
    # Get the second line (actual data)
    data = lines[1].split()

    # Extract the percentage (5th column, like '70%')
    usage_percent = int(data[4].replace('%', ''))

    print(f"Disk Usage: {usage_percent}%")

    if usage_percent > threshold:
        print(f"Warning: Disk usage above {threshold}%!")
    else:
        print("Disk usage is normal.")

# Example usage
check_disk_usage(75)
