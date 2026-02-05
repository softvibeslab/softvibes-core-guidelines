# n8n Workflow Template

Plantilla de workflow automatizado con n8n.

## Workflow JSON

\`\`\`json
{
  "name": "Workflow Example",
  "nodes": [
    {
      "name": "Webhook",
      "type": "n8n-nodes-base.webhook",
      "position": [250, 300]
    },
    {
      "name": "HTTP Request",
      "type": "n8n-nodes-base.httpRequest",
      "position": [450, 300]
    },
    {
      "name": "Set",
      "type": "n8n-nodes-base.set",
      "position": [650, 300]
    }
  ],
  "connections": [
    {
      "source": 0,
      "target": 1
    },
    {
      "source": 1,
      "target": 2
    }
  ]
}
\`\`\`

## Integraciones

- Notion
- Supabase
- OpenAI / Claude
- Slack / Discord / Telegram
- Google Sheets
- Email (SMTP / SendGrid)

---

Generado con OpenClaw
