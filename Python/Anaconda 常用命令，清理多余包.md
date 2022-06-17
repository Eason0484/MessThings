# [](https://blog.csdn.net/weixin_43737010/article/details/108115721)anaconda 清除无用的包，节省空间

```
conda --version

```

```
conda create -n env_name环境名称 python=版本号

```

```
activate env_name

```

```
conda deactivate

```

```
conda env list 显示当前所有环境

```

复制环境

```
conda create --name new_env_name --clone copied_env_name

```

删除环境

```
conda remove -n env_name --all

```

查找包

```
conda serach --full-name package_full_name

```

–full-name:精确查找

package_full_name 被查找包全名

```
conda search text

```

模糊查找

```
conda list  当前环境中已安装包

```

```
conda install --name env_name package_name

```

```
conda install package_name   在当前环境下安装包

```

```
pip install package_name 当conda install 无法安装时

```

```
conda remove --name env_name package_name

```

```
conda remove package_name  卸载当前环境中的包

```

```
conda update --all  或 conda upgrade --all

```

```
conda update package_name 或 conda upgrade package_name

```

清除 conda 里多余的包

```
conda clean -a

```

```
(base) C:\Users\Administrator>conda clean -h
usage: conda-script.py clean [-h] [-a] [-i] [-p] [-t] [-f] [-c TEMPFILES [TEMPFILES ...]] [-d] [--json] [-q] [-v] [-y]

Remove unused packages and caches.

Options:

optional arguments:
  -h, --help            Show this help message and exit.

Removal Targets:
  -a, --all             Remove index cache, lock files, unused cache packages, and tarballs.
  -i, --index-cache     Remove index cache.
  -p, --packages        Remove unused packages from writable package caches. WARNING: This does not check for packages
                        installed using symlinks back to the package cache.
  -t, --tarballs        Remove cached package tarballs.
  -f, --force-pkgs-dirs
                        Remove *all* writable package caches. This option is not included with the --all flag.
                        WARNING: This will break environments with packages installed using symlinks back to the
                        package cache.
  -c TEMPFILES [TEMPFILES ...], --tempfiles TEMPFILES [TEMPFILES ...]
                        Remove temporary files that could not be deleted earlier due to being in-use. Argument is
                        path(s) to prefix(es) where files should be found and removed.

Output, Prompt, and Flow Control Options:
  -d, --dry-run         Only display what would have been done.
  --json                Report all output as json. Suitable for using conda programmatically.
  -q, --quiet           Do not display progress bar.
  -v, --verbose         Can be used multiple times. Once for INFO, twice for DEBUG, three times for TRACE.
  -y, --yes             Do not ask for confirmation.

Examples:

    conda clean --tarballs

```

本文转自 [https://blog.csdn.net/weixin_43737010/article/details/108115721](https://blog.csdn.net/weixin_43737010/article/details/108115721)，如有侵权，请联系删除。
