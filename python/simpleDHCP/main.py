
# Purpose: This file is the main entry point for the program.
import troubleshoot

def main():
    """
    This function initiates the network troubleshooting process.
    """
    try:
        troubleshoot.troubleshoot_network()
    except Exception as e:
        print(f"Error in main: {e}")

if __name__ == "__main__":
    main()
