# Um simples leitor de ultimas mensagens de e-mail e listagem de Lead encontrado, baseando-se em arquivo sample
### Esta aplicação utiliza: 
- pop3 com a gem Mail
- Nokogiri para ler e trabalhar com HTML
- open-uri para ler e baixar arquivos através de URLs HTTP
- RestClient para simular request em um end-point específico.

### A aplicação tem por fim básico:
- Ler um arquivo do tipo EML
- Converter seu HTML
- Retirar trechos importantes de capção de informação
- Acessar links internos encontrados no HTML, onde contém mais informações importantes.
