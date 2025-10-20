import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";
import { componentTagger } from "lovable-tagger";

// 💡 IMPORTANT: Replace <YOUR-REPO-NAME> with the actual name of your GitHub repository.
const base_path = '/<YOUR-REPO-NAME>/';

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => ({
  // 💡 ADD THIS LINE 💡
  base: base_path, 
  // ------------------
  server: {
    host: "::",
    port: 8080,
  },
  plugins: [react(), mode === "development" && componentTagger()].filter(Boolean),
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
}));