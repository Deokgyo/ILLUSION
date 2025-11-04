# 1. 베이스 이미지: Tomcat 9.0 (Java 11 GCA) 버전을 사용합니다.
# (만약 Java 8을 쓰셨다면 tomcat:8.5-jdk8-temurin 등으로 변경)
FROM tomcat:9.0-jdk11-temurin

# 2. (선택사항) Tomcat 기본 환영 페이지 삭제
RUN rm -rf /usr/local/tomcat/webapps/*

# 3. .war 파일 복사 (*** 가장 중요 ***)
# "my-app.war" 부분을 Export로 생성한 .war 파일 이름으로 정확히 바꿔주세요.
# 이 Dockerfile과 같은 폴더에 .war 파일이 있어야 합니다.
COPY *.war /usr/local/tomcat/webapps/ROOT.war
# 4. 포트 노출: Tomcat 기본 포트인 8080 노출
# 4. 포트 노출: Tomcat 기본 포트인 8080 노출
EXPOSE 8080

# 5. 컨테이너 시작 명령어 (Tomcat 실행)
CMD ["catalina.sh", "run"]