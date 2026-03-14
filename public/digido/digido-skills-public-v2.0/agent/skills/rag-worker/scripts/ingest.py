import argparse
import os
import sys
from llama_index.core import VectorStoreIndex, SimpleDirectoryReader, StorageContext, Settings
from llama_index.vector_stores.qdrant import QdrantVectorStore
from llama_index.core.node_parser import SemanticSplitterNodeParser
from llama_index.embeddings.google_genai import GoogleGenAIEmbedding
import qdrant_client

# --- Configuration ---
QDRANT_PATH = "./data/qdrant"
COLLECTION_NAME = "gemini_rag_collection"

def ingest(source_dir, chunk_size=512, chunk_overlap=50):
    if "GOOGLE_API_KEY" not in os.environ:
        print("❌ GOOGLE_API_KEY not set.")
        sys.exit(1)

    if not os.path.exists(source_dir):
        print(f"❌ Source directory not found: {source_dir}")
        sys.exit(1)

    print(f"📥 Loading from: {source_dir}")
    
    # 1. Setup Embedding Model (Gemini)
    print("☁️  Using Gemini Embeddings (models/text-embedding-004)")
    Settings.embed_model = GoogleGenAIEmbedding(model_name="models/text-embedding-004")
    
    # 2. Setup Qdrant Client (On-Disk)
    client = qdrant_client.QdrantClient(path=QDRANT_PATH)
    vector_store = QdrantVectorStore(client=client, collection_name=COLLECTION_NAME)
    storage_context = StorageContext.from_defaults(vector_store=vector_store)

    # 3. Load Documents
    documents = SimpleDirectoryReader(source_dir, recursive=True).load_data()
    print(f"📄 Loaded {len(documents)} document(s).")

    # 4. Semantic Chunking
    splitter = SemanticSplitterNodeParser(
        buffer_size=1, 
        breakpoint_percentile_threshold=95, 
        embed_model=Settings.embed_model
    )
    
    # 5. Indexing
    print("🔄 Indexing...")
    VectorStoreIndex.from_documents(
        documents,
        storage_context=storage_context,
        transformations=[splitter],
        show_progress=True
    )
    print("✅ Ingestion complete.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", required=True)
    parser.add_argument("--chunk-size", type=int, default=512)
    parser.add_argument("--overlap", type=int, default=50)
    
    args = parser.parse_args()
    
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(os.path.dirname(script_dir))

    ingest(args.source, args.chunk_size, args.overlap)
