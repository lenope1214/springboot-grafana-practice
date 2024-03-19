echo "start deploy!"

echo "start build"
chmod +x ./gradlew
# build
./gradlew clean build --stacktrace

echo "kill process"

# 기존 실행 중 프로세스 종료
kill $(jps -lv | awk '/springboot-monitoring.jar/ {print $1}') || true

echo "start cp jar file"

# 파일 복사
cp -f build/libs/*.jar springboot-monitoring.jar

echo "start java"

# 파일 nohup 실행
nohup java -jar springboot-monitoring.jar > /dev/null 2>&1 &
