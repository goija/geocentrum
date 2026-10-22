#!/usr/bin/env python3
import http.server
import os
import re

PORT = 8082
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

class MarkdownRendererHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        clean_path = self.path.split('?')[0]
        full_path = os.path.join(BASE_DIR, clean_path.lstrip('/'))
        
        if clean_path.endswith('.md') and os.path.exists(full_path):
            try:
                with open(full_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                html_content = self.simple_markdown_to_html(content)
                
                page = f"""<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VORTEX OS | Documentatie</title>
    <style>
        :root {{
            --bg-color: #0a0a0a;
            --surface-color: #1a1a1a;
            --text-color: #e0e0e0;
            --accent-color: #00ffcc;
            --font-mono: "Courier New", Courier, monospace;
            --font-sans: system-ui, -apple-system, sans-serif;
        }}
        body {{
            font-family: var(--font-sans);
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
            padding: 40px;
            max-width: 900px;
            margin: 0 auto;
        }}
        a {{ color: var(--accent-color); text-decoration: none; }}
        a:hover {{ text-decoration: underline; }}
        .back-link {{
            display: inline-block;
            margin-bottom: 20px;
            font-family: var(--font-mono);
            font-size: 0.9rem;
        }}
        .content {{
            background-color: var(--surface-color);
            border: 1px solid #333;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.5);
        }}
        h1, h2, h3 {{ color: var(--accent-color); margin-top: 20px; margin-bottom: 10px; font-family: var(--font-mono); }}
        p {{ margin-bottom: 15px; }}
        ul {{ margin-bottom: 15px; padding-left: 20px; }}
        li {{ margin-bottom: 8px; }}
        code {{ background: #111; padding: 2px 6px; border-radius: 4px; font-family: var(--font-mono); color: #00ffcc; }}
        pre {{ background: #111; padding: 15px; border-radius: 6px; overflow-x: auto; font-family: var(--font-mono); border: 1px solid #333; }}
    </style>
</head>
<body>
    <a class="back-link" href="/beheercentrum/index.html">← Terug naar Beheercentrum</a>
    <div class="content">
        {html_content}
    </div>
</body>
</html>
"""
                self.send_response(200)
                self.send_header("Content-type", "text/html; charset=utf-8")
                self.end_headers()
                self.wfile.write(page.encode('utf-8'))
                return
            except Exception as e:
                print(f"Fout bij renderen markdown: {e}")
                
        return super().do_GET()

    def simple_markdown_to_html(self, text):
        lines = text.split('\n')
        html_lines = []
        in_code_block = False
        
        for line in lines:
            if line.startswith('```'):
                if in_code_block:
                    html_lines.append('</pre>')
                    in_code_block = False
                else:
                    html_lines.append('<pre>')
                    in_code_block = True
                continue
                
            if in_code_block:
                html_lines.append(line.replace('<', '&lt;').replace('>', '&gt;'))
                continue
                
            if line.startswith('# '):
                html_lines.append(f'<h1>{line[2:]}</h1>')
            elif line.startswith('## '):
                html_lines.append(f'<h2>{line[3:]}</h2>')
            elif line.startswith('### '):
                html_lines.append(f'<h3>{line[4:]}</h3>')
            elif line.startswith('- '):
                html_lines.append(f'<li>{line[2:]}</li>')
            elif line.strip() == '':
                html_lines.append('<br>')
            else:
                formatted = re.sub(r'`([^`]+)`', r'<code>\1</code>', line)
                html_lines.append(f'<p>{formatted}</p>')
                
        return '\n'.join(html_lines)

if __name__ == '__main__':
    os.chdir(BASE_DIR)
    server_address = ('', PORT)
    httpd = http.server.HTTPServer(server_address, MarkdownRendererHandler)
    print(f"🚀 VORTEX OS Markdown-Server actief op http://localhost:{PORT}")
    httpd.serve_forever()
