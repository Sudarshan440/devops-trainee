import subprocess

def check_service_status(service_name):
    """Check the status of a Linux service."""
    result = subprocess.run(
        ["systemctl", "is-active", service_name],
        capture_output=True,
        text=True
    )
    if result.returncode == 0:
        print(f"{service_name} is running")
    else:
        print(f"{service_name} is NOT running")

# Take input from the user
service = input("Enter the service name to check (e.g. nginx, docker, ssh): ")

# Call the function with user's input 
check_service_status(service)
