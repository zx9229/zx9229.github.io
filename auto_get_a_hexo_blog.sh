# 脚本自动创建一个Hexo的网站文件夹, 并将git版本库和这个文件夹合并.
# shell中, 字符串相等应当怎么写, 这个尚未仔细研究.
# 如果shell语句有语法报错, 某个语句执行失败了的话, 这个还没有检查.
# 搜索"shell 语法错误 立即退出", 可以看到 set -e set -u 之类的解决方式, 尚未验证.

# 使用方式: 当前目录下, 直接运行.


HEXO_DIR="hexo_blog"

echo "====== guess REPO_DIR and HEXO_DIR  ======"
REPO_DIR=$(pwd)
if [ ${REPO_DIR:0-1:1} == "/" ]; then
    echo "will process variable REPO_DIR=${REPO_DIR}"
    REPO_DIR=${REPO_DIR%/*}
fi
HEXO_DIR="${REPO_DIR%/*}/${HEXO_DIR}"
echo "REPO_DIR=${REPO_DIR}"
echo "HEXO_DIR=${HEXO_DIR}"

echo "====== create HEXO_DIR              ======"
if [ ! -d ${HEXO_DIR} ]; then
    mkdir ${HEXO_DIR}
    if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
else
    echo "ERROR: HEXO_DIR exists"
    exit 2
fi

echo "====== change to HEXO_DIR           ======"
cd ${HEXO_DIR}
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
pwd
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== hexo init                    ======"
hexo init
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== npm install                  ======"
npm install
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== hexo-deployer-git            ======"
npm install hexo-deployer-git --save
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== hexo-blog-encrypt            ======"
npm install hexo-blog-encrypt --save
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== change to REPO_DIR           ======"
cd ${REPO_DIR}
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
pwd
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== get all name                 ======"
index=0
for name in *; do
    #if [ ${name} == "*" ]; then
    #    continue
    #fi
    namelist[${index}]="${name}"
    index=$(expr $index + 1)
done
for name in .[^.]*; do
    #if [ ${name} == ".[^.]*" ]; then
    #    continue
    #fi
    namelist[${index}]="${name}"
    index=$(expr $index + 1)
done

echo "There are ${#namelist[@]} names in total. they are:"
for((i=0;i<${#namelist[@]};++i)); do
    name=${namelist[${i}]}
    echo "${name}"
done

echo "====== change to HEXO_DIR           ======"
cd ${HEXO_DIR}
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
pwd
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== create RECYCLE_BIN           ======"
RECYCLE_BIN="recycle_bin"
mkdir "${RECYCLE_BIN}"
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== move all name to RECYCLE_BIN ======"
for((i=0;i<${#namelist[@]};++i)); do
    name=${namelist[${i}]}
    if [ -d "${name}" ] || [ -f "${name}" ]; then
        mv "${name}" "${RECYCLE_BIN}"
        if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
    fi
done

echo "====== change to REPO_DIR           ======"
cd ${REPO_DIR}
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
pwd
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== move all name to HEXO_DIR    ======"
for((i=0;i<${#namelist[@]};++i)); do
    name=${namelist[${i}]}
    mv "${name}" "${HEXO_DIR}"
    if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
done

echo "=========================================="
echo "ALL DONE. SUCCESS."
echo "=========================================="
echo '请阅读文章"为Hexo博客添加目录"并手工合并下面的目录:'
echo "目录1: ${RECYCLE_BIN}/themes/landscape"
echo "目录2: ${HEXO_DIR}/themes/landscape"
echo "可以 : 剪切目录1,并入目录2,利用git恢复目录2的版本库文件"
echo "=========================================="
exit 0
