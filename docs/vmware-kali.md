# VMware Workstation on Kali

Download VMware Workstation from
[Broadcom](https://support.broadcom.com/group/ecx/productfiles?subFamily=VMware%20Workstation%20Pro&displayGroup=VMware%20Workstation%20Pro%2017.0%20for%20Personal%20Use%20(Linux)&release=17.5.2&os=&servicePk=520450&language=EN).

Install the build dependencies:

```sh
sudo apt install -y build-essential linux-headers-$( uname -r ) vlan libaio1
```

If the `vmnet` modules fail to build, drop these lines from the kernel headers'
`Makefile.modfinal`:

```sh
sudo nvim /usr/src/linux-headers-6.8.11-amd64/scripts/Makefile.modfinal
```

```diff
-ifdef CONFIG_DEBUG_INFO_BTF_MODULES
-        +$(if $(newer-prereqs),$(call cmd,btf_ko))
-endif
```

## Guest activation

<https://github.com/massgravel/Microsoft-Activation-Scripts>
