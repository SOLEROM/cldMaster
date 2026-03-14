import subprocess
import sys
import os

def install_dependencies():
    """Install required Python packages."""
    print("📦 Installing dependencies...")
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])
        print("✅ Dependencies installed.")
    except subprocess.CalledProcessError:
        print("❌ Failed to install dependencies.")
        sys.exit(1)

def check_env():
    """Check for Google API Key."""
    print("\n☁️  Checking Google Gemini configuration...")
    if "GOOGLE_API_KEY" not in os.environ:
        print("❌ GOOGLE_API_KEY environment variable not found.")
        print("   Please set it to use the Gemini-powered RAG:")
        print("   Windows (PowerShell): $env:GOOGLE_API_KEY='your_key_here'")
        print("   Windows (CMD): set GOOGLE_API_KEY=your_key_here")
        sys.exit(1)
    else:
        print("✅ GOOGLE_API_KEY found.")

def init_qdrant():
    """Ensure Qdrant data directory exists."""
    data_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "data", "qdrant")
    if not os.path.exists(data_path):
        os.makedirs(data_path)
    print(f"📁 Qdrant data directory ready: {data_path}")

if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(os.path.dirname(script_dir))

    install_dependencies()
    check_env()
    init_qdrant()
    
    print("\n✨ Setup complete! You can now run ingest.py")
