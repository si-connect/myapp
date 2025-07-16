# Stage 1: Build dell'app Angular
FROM node:20-alpine as build

# Directory di lavoro
WORKDIR /app

# Copia package.json e package-lock.json (se c'è)
COPY package*.json ./

# Installa le dipendenze
RUN npm install

# Copia tutto il codice sorgente
COPY . .

# Costruisci l'app in modalità produzione
RUN npm run build --prod

# Stage 2: Immagine di runtime con Nginx
FROM nginx:alpine

# Copia la build prod da Stage 1 nella cartella di Nginx
COPY --from=build /app/dist/<nome-tua-app> /usr/share/nginx/html

# Espone la porta 80
EXPOSE 80

# Comando di default per avviare Nginx
CMD ["nginx", "-g", "daemon off;"]

