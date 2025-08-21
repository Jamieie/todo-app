# Multi-stage build를 위한 빌드 스테이지
FROM gradle:8.5-jdk17 AS builder

# 작업 디렉토리 설정
WORKDIR /app

# Gradle 설정 파일들 먼저 복사 (캐시 최적화)
COPY build.gradle settings.gradle ./
COPY gradle/ gradle/

# 의존성 다운로드 (캐시 레이어)
RUN gradle dependencies --no-daemon

# 소스 코드 복사
COPY . .

# WAR 파일 빌드
RUN gradle clean war --no-daemon

# 런타임 스테이지
FROM tomcat:10.1-jdk17

# 기본 ROOT 앱 제거
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# 빌드된 WAR 파일을 ROOT.war로 복사
COPY --from=builder /app/build/libs/todo-app-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# 포트 노출 (Render는 PORT 환경변수 사용)
EXPOSE 8080

# Tomcat 시작
CMD ["catalina.sh", "run"]