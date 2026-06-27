# 🖥️ Guia: Bot em Múltiplos Servidores

Este bot pode rodar em quantos servidores Discord você quiser usando **um único token**. Cada servidor pode ter configurações específicas.

## 📋 Como Funciona

1. **Um token = Múltiplos servidores**: Você convida o bot para quantos servidores quiser
2. **Configurações por servidor**: Cada servidor pode ter canais, cargos e prefixos diferentes
3. **Arquivo JSON**: Todas as configs são armazenadas em `serverConfigs.json`

## 🔧 Como Adicionar um Novo Servidor

### 1️⃣ Obter o ID do Servidor (Guild ID)

No Discord:
- Ative **Modo de Desenvolvedor** (User Settings → Advanced → Developer Mode)
- Clique com botão direito no servidor
- Clique em "Copy Server ID"

### 2️⃣ Atualizar `serverConfigs.json`

Abra o arquivo e adicione uma nova entrada:

```json
{
  "default": { ... },
  "SEU_SERVIDOR_NOME": {
    "serverGuildId": "COLE_GUILD_ID_AQUI",
    "prefix": "!",
    "adChannelIds": ["ID_CANAL_1", "ID_CANAL_2"],
    "logChannelIds": {
      "entradas": "ID_DO_CANAL",
      "saidas": "ID_DO_CANAL",
      "banimentos": "ID_DO_CANAL",
      "geral": "ID_DO_CANAL"
    },
    "registro": {
      "painelCanalId": "ID_DO_CANAL",
      "logCanalId": "ID_DO_CANAL",
      "cargoLiderId": "ID_DO_CARGO",
      "cargoAprovadoId": "ID_DO_CARGO",
      "cargoRecrutadorId": "ID_DO_CARGO"
    },
    "verificacao": {
      "cargoVerificadoId": "ID_DO_CARGO"
    },
    "tickets": {
      "logChannelId": "ID_DO_CANAL",
      "cargoEquipeId": "ID_DO_CARGO"
    }
  }
}
```

### 3️⃣ Como Obter IDs de Canais e Cargos

**Canal ID:**
- Clique com botão direito no canal
- "Copy Channel ID"

**Cargo ID:**
- Clique com botão direito no cargo
- "Copy Role ID"

## 📝 Exemplo Prático

Se você tem 2 servidores:

```json
{
  "default": { ... },
  
  "SERVIDOR_PRINCIPAL": {
    "serverGuildId": "123456789012345678",
    "prefix": "!",
    "adChannelIds": ["987654321098765432"],
    "registro": {
      "painelCanalId": "111111111111111111",
      "logCanalId": "222222222222222222",
      ...
    }
  },
  
  "SERVIDOR_SECUNDARIO": {
    "serverGuildId": "999999999999999999",
    "prefix": ".",
    "adChannelIds": ["888888888888888888"],
    "registro": {
      "painelCanalId": "777777777777777777",
      "logCanalId": "666666666666666666",
      ...
    }
  }
}
```

## 🚀 Convidando o Bot para Novo Servidor

1. Vá em: https://discord.com/developers/applications
2. Selecione seu bot
3. Vá em "OAuth2" → "URL Generator"
4. Selecione as permissões necessárias
5. Copie a URL gerada
6. Cole no navegador e convide para os servidores

## 💡 Dicas

- **Deixe o .env como fallback**: Se um servidor não estiver em `serverConfigs.json`, as variáveis do `.env` serão usadas
- **Prefixo diferente**: Cada servidor pode usar um prefixo diferente (!, ., >, etc)
- **Teste em dev**: Crie um servidor de teste para validar as configs antes de usar em produção
- **Não compartilhe o token**: O `DISCORD_TOKEN` no `.env` é secreto, nunca compartilhe

## ❌ Troubleshooting

**"Bot não responde em um servidor"**
- Verifique se o `serverGuildId` está correto
- Verifique se os IDs dos canais existem no servidor

**"Comando não funciona"**
- Verifique se o prefixo está correto no `serverConfigs.json`
- Verifique as permissões do bot no servidor

**"Logs não são salvos"**
- Verifique se os `logChannelIds` estão preenchidos
- Verifique se o bot tem permissão de escrever no canal
