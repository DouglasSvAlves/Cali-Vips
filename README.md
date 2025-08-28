# 💰 Script de Pagamentos VIP - California Roleplay (QBCore)

Este recurso foi desenvolvido para o servidor **California Roleplay**, utilizando a framework **QBCore**.  
O sistema realiza **pagamentos automáticos para jogadores VIPs**, em intervalos definidos no `config.lua`, com integração direta à **API do Badger Discord**.  

O objetivo é oferecer uma forma prática e automatizada de gerenciar benefícios de assinantes VIP, garantindo que apenas jogadores com cargos ativos no Discord recebam o salário no jogo.

---

## ✨ Funcionalidades
- ⏱️ **Pagamentos automáticos** para jogadores VIP em intervalos configuráveis (ex.: a cada 30 minutos).  
- 🔗 **Integração com [Badger Discord API](https://github.com/JaredScar/Badger_Discord_API)**.
- 🔗 **Registro de Logs via Web-hooks do Discord**.   
- 👥 Verificação em tempo real dos **cargos do Discord** vinculados ao jogador.  
- 🚫 Se o jogador perder o cargo VIP no Discord, o benefício é automaticamente removido.  
- 💵 Salário recebido diretamente **in-game** na carteira/banco do player.  
- ⚙️ Configuração simples no `config.lua`.  

---

## 🛠️ Tecnologias Utilizadas
- [QBCore Framework](https://github.com/qbcore-framework)  
- [Badger Discord API](https://github.com/JaredScar/Badger_Discord_API)  
- **Lua**  

---

## ⚙️ Instalação
1. Adicione no seu server.cfg:
>  ensure Cali-Vips

