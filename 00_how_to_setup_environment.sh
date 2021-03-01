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
# install awscliv2
curl -O https://awscli.amazonaws.com/AWSCLIV2.pkg
installer -pkg AWSCLIV2.pkg -target /
# install dotnet
curl https://download.visualstudio.microsoft.com/download/pr/43e9caf4-2087-4bc6-8031-5efba1268703/a6b0491578d385a9780603ea51df8de9/dotnet-sdk-5.0.103-osx-x64.pkg -o dotnet.pkg
installer -pkg dotnet.pkg -target /

# add programs to path
editor ~/.bash_profile
JAVA_HOME="/Library/java/JavaVirtualMachines/amazon-corretto-15.jdk/Contents/Home"
PYTHON="/Library/Frameworks/Python.framework/Versions/3.9/bin"
VSCODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
MAVEN="/Library/java/maven/bin"
SUBLIME="/Applications/Sublime Text.app/Contents/SharedSupport/bin"
DOTNET="/usr/local/share/dotnet/"
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PYTHON:$JAVA_HOME/bin:$MAVEN:$VSCODE:$SUBLIME:$DOTNET:"
export PATH
