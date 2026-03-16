# 1단계: 빌드 (Node.js 환경)
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 2단계: 실행 (Nginx 환경)
FROM nginx:stable-alpine
# CRA의 기본 빌드 폴더명은 'build'입니다. (Vite는 dist)
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]