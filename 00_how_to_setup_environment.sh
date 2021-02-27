# install prerequisites on MacOS
# install visual studio code https://go.microsoft.com/fwlink/?LinkID=534106
cd ~/downloads
sudo sh
# install openJDK
curl -L https://corretto.aws/downloads/latest/amazon-corretto-15-x64-macos-jdk.pkg -o corretto.pkg
installer -pkg corretto.pkg -target /
# install maven
curl https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -o maven.tar.gz
tar xzvf maven.tar.gz --directory maven --strip-components=1
mv maven /Library/Java/
# install node
curl https://nodejs.org/dist/v15.10.0/node-v15.10.0.pkg -o node.pkg
installer -pkg node.pkg -target /
npm install -g yarn projen
exit

editor ~/.bash_profile
JAVA_HOME="/Library/java/JavaVirtualMachines/amazon-corretto-15.jdk/Contents/Home"
PYTHON="/Library/Frameworks/Python.framework/Versions/3.9/bin"
VSCODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
MAVEN="/Library/java/maven/bin"
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PYTHON:$JAVA_HOME/bin:$MAVEN:$VSCODE"
export PATH
