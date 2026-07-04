~~~python
# pip install modelscope

# If you can't download llama from huggingface, use this script.

import os
from modelscope.hub.snapshot_download import snapshot_download

def download_llama_model():
    # 1. Specify the ModelScope model ID for Llama-3.1-8B
    model_id = "LLM-Research/Meta-Llama-3.1-8B"

    # 2. Specify your desired download directory
    download_dir = os.path.abspath("/nfs/models/Llama-3.1-8B-Instruct")
    os.makedirs(download_dir, exist_ok=True)
    
    print(f"Starting download of {model_id}...")
    print(f"Target directory: {download_dir}")
    
    # 3. Download the model (this will only download missing files if interrupted)
    model_path = snapshot_download(
        model_id,
        cache_dir=download_dir
    )
    
    print(f"Download complete! Model saved at: {model_path}")

if __name__ == "__main__":
    download_llama_model()
~~~



