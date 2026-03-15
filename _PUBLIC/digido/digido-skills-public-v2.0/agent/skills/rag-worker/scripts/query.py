import argparse
import os
import sys
from llama_index.core import VectorStoreIndex, StorageContext, Settings
from llama_index.vector_stores.qdrant import QdrantVectorStore
from llama_index.core.retrievers import VectorIndexRetriever
from llama_index.core import get_response_synthesizer
from llama_index.core.query_engine import RetrieverQueryEngine
from llama_index.llms.google_genai import Gemini
from llama_index.embeddings.google_genai import GoogleGenAIEmbedding
import qdrant_client

# --- Configuration ---
QDRANT_PATH = "./data/qdrant"
COLLECTION_NAME = "gemini_rag_collection"

def query_kb(query_text, top_k=5):
    if "GOOGLE_API_KEY" not in os.environ:
        print("❌ GOOGLE_API_KEY not set.")
        sys.exit(1)

    # 1. Setup Models
    print("☁️  Using Gemini Flash 1.5 & Text Embedding 004")
    Settings.llm = Gemini(model="models/gemini-1.5-flash")
    Settings.embed_model = GoogleGenAIEmbedding(model_name="models/text-embedding-004")

    # 2. Connect to Qdrant
    if not os.path.exists(QDRANT_PATH):
        print("❌ Knowledge base not found. Run 'ingest.py' first.")
        sys.exit(1)
        
    client = qdrant_client.QdrantClient(path=QDRANT_PATH)
    vector_store = QdrantVectorStore(client=client, collection_name=COLLECTION_NAME)
    index = VectorStoreIndex.from_vector_store(vector_store=vector_store)

    # 3. Retrieve
    retriever = VectorIndexRetriever(index=index, similarity_top_k=top_k)
    response_synthesizer = get_response_synthesizer(response_mode="compact")
    
    query_engine = RetrieverQueryEngine(
        retriever=retriever,
        response_synthesizer=response_synthesizer,
    )

    # 4. Execute
    print(f"🔍 Searching: '{query_text}'...")
    response = query_engine.query(query_text)
    
    print("\n--- ANSWER ---")
    print(response)
    print("\n--- SOURCES ---")
    for node in response.source_nodes:
        # Safe access to content
        content = node.node.get_content()
        preview = content[:100].replace('\n', ' ') + "..." if content else "No content"
        print(f"- Score: {node.score:.2f} | {preview}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--query", required=True)
    parser.add_argument("--top-k", type=int, default=5)
    
    args = parser.parse_args()
    
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(os.path.dirname(script_dir))

    query_kb(args.query, args.top_k)
