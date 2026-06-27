# 🤖 Bot de Anúncios & Música para Discord

Bot de Discord para gerenciar e enviar anúncios em massa para múltiplos canais **e** tocar música em canais de voz. Cadastre seus anúncios, envie todos de uma vez e ainda curta suas músicas favoritas!

---

## 📋 Índice

- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Criando o Bot no Discord Developer Portal](#-criando-o-bot-no-discord-developer-portal)
- [Configuração do Arquivo .env](#-configuração-do-arquivo-env)
  - [Obtendo o Token do Bot](#obtendo-o-token-do-bot)
  - [Obtendo os IDs dos Canais](#obtendo-os-ids-dos-canais)
- [Como Usar](#-como-usar)
- [Comandos de Anúncios](#-comandos-de-anúncios)
  - [!addad](#addad)
  - [!myads](#myads)
  - [!allads](#allads)
  - [!sendads](#sendads)
  - [!removead](#removead)
  - [!clearads](#clearads)
- [Comandos de Música](#-comandos-de-música)
  - [!play](#play)
  - [!skip](#skip)
  - [!stop](#stop)
  - [!pause e !resume](#pause-e-resume)
  - [!queue](#queue)
  - [!nowplaying](#nowplaying)
  - [!leave](#leave)
- [Exemplo de Fluxo Completo](#-exemplo-de-fluxo-completo)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Solução de Problemas](#-solução-de-problemas)
- [Notas Importantes](#-notas-importantes)

---

## 🔧 Pré-requisitos

- [Node.js](https://nodejs.org/) versão 16.9.0 ou superior
- Uma conta no Discord com acesso a um servidor
- Permissão para adicionar bots ao servidor (ou ser o dono do servidor)

---

## 📦 Instalação

1. Clone ou baixe este projeto para sua máquina local.

2. Abra um terminal na pasta do projeto e instale as dependências:

```bash
npm install
```

Isso instalará automaticamente:
- **discord.js** (v14) — biblioteca principal para interação com a API do Discord
- **dotenv** — carrega variáveis de ambiente do arquivo `.env`

---

## 🛠️ Criando o Bot no Discord Developer Portal

### Passo 1: Criar a Aplicação

1. Acesse o [Discord Developer Portal](https://discord.com/developers/applications).
2. Clique no botão **"New Application"** no canto superior direito.
3. Dê um nome à aplicação (ex: "Meu Bot de Anúncios") e clique em **"Create"**.

### Passo 2: Configurar o Bot

1. No menu lateral esquerdo, clique em **"Bot"**.
2. Clique em **"Reset Token"** (ou "View Token") e **copie o token**.
   > ⚠️ **IMPORTANTE:** Guarde este token em um local seguro. Ele não será exibido novamente.
3. Role para baixo até a seção **"Privileged Gateway Intents"** e ative:
   - ✅ **MESSAGE CONTENT INTENT** (obrigatório para o bot ler mensagens)
   - ✅ **SERVER MEMBERS INTENT** (recomendado)
   - ✅ **PRESENCE INTENT** (opcional)
4. Clique em **"Save Changes"**.

### Passo 3: Convidar o Bot para o Servidor

1. No menu lateral, clique em **"OAuth2"** → **"URL Generator"**.
2. Na seção **"Scopes"**, marque:
   - ✅ **`bot`**
3. Na seção **"Bot Permissions"** que aparecerá abaixo, marque:
   - ✅ **Send Messages**
   - ✅ **Embed Links**
   - ✅ **Read Message History**
   - ✅ **Read Messages/View Channels**
   - ✅ **Connect** (para entrar em canais de voz)
   - ✅ **Speak** (para tocar música)
4. Copie a **URL gerada** na parte inferior da página.
5. Cole essa URL no navegador e selecione o servidor onde deseja adicionar o bot.
6. Clique em **"Authorize"** e confirme.

---

## ⚙️ Configuração do Arquivo .env

O arquivo `.env` fica na raiz do projeto e contém todas as configurações do bot. Abra-o com qualquer editor de texto e preencha os valores:

```env
# Token do seu bot Discord (pegue em https://discord.com/developers/applications)
DISCORD_TOKEN=seu_token_aqui

# ID dos canais onde você tem seus anúncios (separados por vírgula)
AD_CHANNEL_IDS=111111111111111111,222222222222222222,333333333333333333

# Prefixo dos comandos do bot
PREFIX=!
```

### Obtendo o Token do Bot

1. Acesse o [Discord Developer Portal](https://discord.com/developers/applications).
2. Clique na sua aplicação.
3. No menu lateral, vá em **"Bot"**.
4. Clique em **"Reset Token"** ou **"View Token"**.
5. Copie o token e cole no lugar de `seu_token_aqui` no `.env`.

### Obtendo os IDs dos Canais

O Discord esconde os IDs por padrão. Para vê-los, você precisa ativar o **Modo Desenvolvedor**:

1. Abra o Discord (desktop ou web).
2. Vá em **Configurações de Usuário** (ícone de engrenagem ⚙️ no canto inferior esquerdo).
3. No menu lateral, clique em **"Avançado"** (em "App Settings").
4. Ative a opção **"Modo Desenvolvedor"** (Developer Mode).
5. Agora, clique com o **botão direito** em qualquer canal e selecione **"Copiar ID"** (Copy ID).
6. Cole o ID no campo `AD_CHANNEL_IDS` do `.env`.

> 💡 **Dica:** Para adicionar múltiplos canais, separe os IDs com vírgula, sem espaços:
> ```
> AD_CHANNEL_IDS=111111111111111111,222222222222222222,333333333333333333
> ```

---

## 🚀 Como Usar

1. Certifique-se de que o `.env` está configurado corretamente (token e canais).
2. Abra um terminal na pasta do projeto.
3. Inicie o bot:

```bash
npm start
```

4. Você verá a mensagem:
```
✅ Bot online como: NomeDoBot#1234
📢 Canais de anúncios configurados: 3
   - Canal ID: 111111111111111111
   - Canal ID: 222222222222222222
   - Canal ID: 333333333333333333
```

5. Vá em qualquer canal do Discord onde o bot está presente e comece a usar os comandos!

---

## 📢 Comandos de Anúncios

O prefixo padrão é `!` (configurável no `.env`).

---

### `!addad`

Cadastra um novo anúncio.

**Formato:**
```
!addad <título> | <descrição> | [preço]
```

**Exemplos:**
```
!addad Camiseta Nike | Tamanho G, preta, nova com etiqueta | R$ 80,00
!addad PS5 Usado | Console em ótimo estado, com 2 controles | R$ 2.500,00
!addd Aula de Inglês | Professor nativo, aulas online | Consultar
```

> O campo **preço** é opcional. Se não informado, será exibido como "Consultar".

**Resposta do bot:**
```
✅ Anúncio Adicionado!
📌 Título:    Camiseta Nike
📝 Descrição: Tamanho G, preta, nova com etiqueta
💰 Preço:     R$ 80,00
🆔 ID:        1719234567890
```

---

### `!myads`

Lista todos os anúncios que **você** cadastrou.

**Formato:**
```
!myads
```

**Resposta do bot:**
```
📋 Seus Anúncios (2)

Camiseta Nike (ID: 1719234567890)
Tamanho G, preta, nova com etiqueta
💰 R$ 80,00

PS5 Usado (ID: 1719234599999)
Console em ótimo estado, com 2 controles
💰 R$ 2.500,00
```

---

### `!allads`

Lista todos os anúncios cadastrados por **todos os usuários**.

**Formato:**
```
!allads
```

---

### `!sendads`

**Comando principal.** Envia todos os anúncios cadastrados para todos os canais configurados no `.env`.

**Formato:**
```
!sendads
```

**Resposta do bot:**
```
📤 Enviando 2 anúncio(s) para 3 canal(is)...

📊 Resultado do Envio
✅ Sucesso:          3 canal(is)
❌ Falha:            0 canal(is)
📢 Anúncios enviados: 2
```

> ⚠️ Os anúncios são enviados um por vez com um pequeno delay de 500ms entre cada um para evitar rate limit da API do Discord.

---

### `!removead`

Remove um anúncio específico pelo ID. Só é possível remover seus próprios anúncios.

**Formato:**
```
!removead <id_do_anúncio>
```

**Exemplo:**
```
!removead 1719234567890
```

> 💡 Use `!myads` para ver os IDs dos seus anúncios.

---

### `!clearads`

Remove **todos os seus** anúncios cadastrados de uma vez.

**Formato:**
```
!clearads
```

---

### `!help`

Exibe uma embed com todos os comandos disponíveis (anúncios e música) e suas descrições.

**Formato:**
```
!help
```
ou
```
!ajuda
```

---

## 🎵 Comandos de Música

> ⚠️ Para usar os comandos de música, você precisa estar conectado a um **canal de voz** do Discord.

---

### `!play`

Toca uma música do YouTube ou adiciona à fila se já estiver tocando algo. Aceita **nome da música** ou **URL do YouTube**.

**Aliases:** `!p`, `!tocar`

**Formato:**
```
!play <nome da música ou URL do YouTube>
```

**Exemplos:**
```
!play Never Gonna Give You Up
!play https://www.youtube.com/watch?v=dQw4w9WgXcQ
!p lofi hip hop radio
```

**Resposta do bot (primeira música):**
```
🎶 Tocando Agora
[Never Gonna Give You Up](https://youtube.com/...)
⏱️ Duração: 3:33
👤 Pedido por: @SeuNome
```

**Resposta do bot (adicionado à fila):**
```
➕ Adicionado à Fila
[Never Gonna Give You Up](https://youtube.com/...)
📍 Posição: 3 | ⏱️ Duração: 3:33
```

---

### `!skip`

Pula a música atual e toca a próxima da fila.

**Aliases:** `!s`, `!pular`

**Formato:**
```
!skip
```

---

### `!stop`

Para a música atual, limpa toda a fila e faz o bot sair do canal de voz.

**Aliases:** `!parar`

**Formato:**
```
!stop
```

---

### `!pause` e `!resume`

**`!pause`** (alias: `!pausar`) — Pausa a música atual.

**`!resume`** (aliases: `!despausar`, `!continuar`) — Retoma a música pausada.

**Formato:**
```
!pause
!resume
```

---

### `!queue`

Mostra a música tocando atualmente e as próximas 10 músicas da fila.

**Aliases:** `!q`, `!fila`

**Formato:**
```
!queue
```

**Resposta do bot:**
```
🎵 Fila de Músicas
Tocando agora:
[Never Gonna Give You Up](https://youtube.com/...)

📋 Próximas (2)
2. [Bohemian Rhapsody](https://youtube.com/...)
3. [Hotel California](https://youtube.com/...)
```

---

### `!nowplaying`

Mostra detalhes da música que está tocando no momento.

**Aliases:** `!np`

**Formato:**
```
!nowplaying
```

---

### `!leave`

Faz o bot sair do canal de voz sem limpar a fila explicitamente (para a música e desconecta).

**Aliases:** `!sair`, `!disconnect`

**Formato:**
```
!leave
```

---

### `!help` (atualizado)

Exibe uma embed com **todos os comandos** de anúncios e música.

**Formato:**
```
!help
```
ou
```
!ajuda
```

---

## 📖 Exemplo de Fluxo Completo

Aqui está um exemplo completo de uso do bot, do cadastro ao envio:

```
👤 Usuário: !addad Tênis Adidas | Tamanho 42, usado 2 vezes | R$ 150,00
🤖 Bot:     ✅ Anúncio Adicionado! (ID: 1719234567890)

👤 Usuário: !addad Fone Bluetooth | Novo, na caixa, frete grátis
🤖 Bot:     ✅ Anúncio Adicionado! (ID: 1719234599999)

👤 Usuário: !myads
🤖 Bot:     📋 Seus Anúncios (2)
            - Tênis Adidas (ID: 1719234567890) — R$ 150,00
            - Fone Bluetooth (ID: 1719234599999) — Consultar

👤 Usuário: !sendads
🤖 Bot:     📤 Enviando 2 anúncio(s) para 3 canal(is)...
            📊 Resultado: ✅ 3 sucesso | ❌ 0 falha
```

Após o `!sendads`, cada canal configurado receberá embeds como:

```
📢 Tênis Adidas
Tamanho 42, usado 2 vezes
💰 Preço:    R$ 150,00
👤 Vendedor: @SeuNome
```

---

## 🗂️ Estrutura do Projeto

```
projeto/
├── index.js          # Código principal do bot
├── ads.json          # Armazena os anúncios cadastrados (gerado automaticamente)
├── .env              # Variáveis de ambiente (token, canais, prefixo)
├── .gitignore        # Ignora node_modules, .env e ads.json no git
├── package.json      # Metadados e dependências do projeto
└── node_modules/     # Dependências instaladas (não versionar)
```

| Arquivo | Descrição |
|---|---|
| `index.js` | Toda a lógica do bot: conexão, comandos de anúncios e música, fila de reprodução |
| `ads.json` | Base de dados local onde os anúncios são persistidos |
| `.env` | Configurações sensíveis — **nunca compartilhe este arquivo** |
| `package.json` | Scripts e dependências do Node.js |

**Dependências principais:**

| Pacote | Função |
|---|---|
| `discord.js` v14 | Interação com a API do Discord (mensagens, embeds, canais) |
| `@discordjs/voice` | Conexão com canais de voz e reprodução de áudio |
| `play-dl` | Busca e streaming de músicas do YouTube |
| `dotenv` | Carrega variáveis de ambiente do arquivo `.env` |

---

## 🔍 Solução de Problemas

### ❌ "Erro ao conectar o bot: An invalid token was provided"

**Causa:** O token no `.env` está incorreto ou vazio.

**Solução:**
1. Abra o `.env` e verifique se `DISCORD_TOKEN` contém o token correto.
2. O token **não** deve ter aspas, espaços ou quebras de linha.
3. Se perdeu o token, vá em [Discord Developer Portal](https://discord.com/developers/applications) → sua aplicação → Bot → Reset Token.

---

### ❌ "Erro ao conectar o bot: Privileged intent(s) provided without allowing it as a developer option"

**Causa:** O **MESSAGE CONTENT INTENT** não está ativado.

**Solução:**
1. Acesse o Discord Developer Portal → sua aplicação → Bot.
2. Ative **"MESSAGE CONTENT INTENT"**.
3. Salve e reinicie o bot.

---

### ❌ "Erro ao enviar para canal XXXXX: Missing Permissions"

**Causa:** O bot não tem permissão para enviar mensagens naquele canal.

**Solução:**
1. No Discord, vá nas **Configurações do Canal** (ícone de engrenagem ao lado do nome do canal).
2. Clique em **"Permissões"**.
3. Adicione o bot e garanta as permissões:
   - ✅ View Channel
   - ✅ Send Messages
   - ✅ Embed Links
   - ✅ Read Message History

---

### ❌ "!sendads não envia nada / diz que nenhum canal está configurado"

**Causa:** O campo `AD_CHANNEL_IDS` no `.env` está vazio ou com formato errado.

**Solução:**
1. Verifique se os IDs estão separados por vírgula, **sem espaços**:
   ```env
   # ✅ Correto
   AD_CHANNEL_IDS=111111111111111111,222222222222222222

   # ❌ Errado (espaços entre IDs)
   AD_CHANNEL_IDS=111111111111111111, 222222222222222222
   ```
2. Confirme que os IDs são de canais de texto (não de voz ou categorias).
3. Para pegar o ID: botão direito no canal → Copiar ID (com Modo Desenvolvedor ativo).

---

### ❌ "Cannot read properties of undefined (reading 'split')"

**Causa:** O arquivo `.env` pode estar com codificação errada (UTF-8 com BOM, por exemplo).

**Solução:**
1. Abra o `.env` em um editor como VS Code ou Notepad++.
2. Salve o arquivo com codificação **UTF-8 sem BOM**.
3. Verifique que a primeira linha começa com `DISCORD_TOKEN=` (sem espaços ou caracteres invisíveis).

---

### ❌ O bot fica online mas não responde a comandos

**Causas possíveis:**

1. **Prefixo diferente:** Verifique o `PREFIX` no `.env`. Se for `!`, os comandos devem começar com `!` (ex: `!addad`).
2. **Bot sem permissão de leitura:** Confirme que o bot tem acesso ao canal (View Channel).
3. **MESSAGE CONTENT INTENT desativado:** Ative-o no Developer Portal (veja erro acima).

---

### ❌ "Error: Used disallowed intents"

**Causa:** Você ativou um intent que não foi aprovado pela Discord.

**Solução:**
- Para bots em menos de 100 servidores, todos os intents funcionam normalmente.
- Verifique no Developer Portal se os intents estão salvos corretamente.
- Reinicie o bot após salvar as alterações.

---

### ❌ "Você precisa estar em um canal de voz para usar este comando!"

**Causa:** Você não está conectado a nenhum canal de voz.

**Solução:**
1. Entre em um canal de voz no Discord.
2. Execute o comando `!play` novamente.

---

### ❌ "Já estou tocando em outro canal de voz!"

**Causa:** O bot já está tocando em outro canal de voz diferente do seu.

**Solução:**
1. Entre no mesmo canal de voz onde o bot está tocando.
2. Ou use `!leave` para fazer o bot sair e depois use `!play` no seu canal.

---

### ❌ "Erro ao buscar/tocar a música" ao usar !play

**Causas possíveis:**

1. **URL inválida:** Verifique se a URL do YouTube está correta.
2. **Vídeo indisponível:** O vídeo pode estar privado, restrito por idade ou bloqueado.
3. **Termo de busca sem resultados:** Tente usar termos mais específicos ou cole a URL direta.

---

### ❌ Música não toca / som mudo no canal de voz

**Causa:** O bot não tem permissões de voz adequadas.

**Solução:**
1. Verifique se o bot tem as permissões **Connect** e **Speak** no canal de voz.
2. Vá em **Configurações do Canal de Voz → Permissões** e adicione o bot com essas permissões.
3. Reinicie o bot após conceder as permissões.

---

## 📌 Notas Importantes

- **Segurança do Token:** Nunca compartilhe seu token do bot. Ele está no `.gitignore` para não ser enviado acidentalmente ao Git. Se o token vazar, qualquer pessoa pode controlar seu bot.

- **Rate Limit:** O bot envia anúncios com um intervalo de 500ms entre cada um para evitar ser bloqueado temporariamente pela API do Discord.

- **Limite de Campos em Embeds:** Cada embed do Discord suporta no máximo 25 campos. Por isso, `!myads` e `!allads` exibem apenas os 25 primeiros anúncios.

- **Persistência de Dados:** Os anúncios são salvos localmente no arquivo `ads.json`. Se o projeto for movido ou apagado, os anúncios serão perdidos. Faça backup periodicamente.

- **Bots em Múltiplos Servidores:** O bot pode estar em vários servidores, mas só enviará anúncios para os canais cujos IDs estão no `.env`.

- **Uso Responsável:** Envie anúncios apenas para servidores e canais onde você tem permissão. Envio em massa não solicitado pode resultar em banimento do bot e da sua conta.

- **Música via YouTube:** O bot usa a biblioteca `play-dl` para buscar e tocar músicas do YouTube. Funciona com URLs diretas ou busca por nome. A qualidade do áudio depende do stream do YouTube.

- **Fila de Música:** A fila é por servidor (guild), não por canal de texto. Todos os canais de texto do mesmo servidor compartilham a mesma fila.

- **Auto-disconnect:** Se a fila ficar vazia, o bot avisa e sai do canal de voz automaticamente após 30 segundos.

---

## 📄 Licença

Este projeto é de uso livre para fins pessoais e educacionais.
