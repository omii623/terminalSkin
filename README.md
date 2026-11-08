# terminalSkin

Kétsoros, színes terminál prompt **Bash**-hez (Linux, Git Bash, WSL) és **PowerShell**-hez.

**Bash** (`bashrc`):
```
┌─[✗]─[user@host]─[main]─[~/projektek/app]
└──╼ $
```

**PowerShell** (`profile.ps1`):
```
┌─[✗]─[user@host]─[main]─[~\projektek\app]
└─[PS]─╼ $
```

## Mit tud

- `[✗]` jelzés, ha az előző parancs hibával tért vissza
- Az aktuális git branch (detached HEAD esetén a commit hash)
- Root / rendszergazda módban piros felhasználónév, és `#` jelenik meg a `$` helyett
- A home mappa rövidítve, `~` alakban
- Ablakcím: `user@host: mappa`

## Telepítés

### Linux / Git Bash

```bash
cp ~/.bashrc ~/.bashrc.bak 2>/dev/null; curl -fsSL https://raw.githubusercontent.com/omii623/terminalSkin/main/bashrc -o ~/.bashrc && source ~/.bashrc
```

A meglévő `~/.bashrc` fájlt `~/.bashrc.bak` néven elmenti.

Visszaállítás:
```bash
cp ~/.bashrc.bak ~/.bashrc && source ~/.bashrc
```

### PowerShell (Windows)

```powershell
if (Test-Path $PROFILE) { Copy-Item $PROFILE "$PROFILE.bak" -Force } else { New-Item -Force -ItemType File $PROFILE | Out-Null }; Invoke-WebRequest https://raw.githubusercontent.com/omii623/terminalSkin/main/profile.ps1 -OutFile $PROFILE; Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force
```

Nyiss egy új PowerShell ablakot, és már az új prompt jelenik meg.

- A meglévő profilt `.bak` kiterjesztéssel elmenti.
- A `Set-ExecutionPolicy` sor engedélyezi a helyi scriptek futtatását a saját felhasználódnak, mert enélkül a profil nem tud lefutni.
- A Windows PowerShell 5.1-nek és a PowerShell 7-nek (`pwsh`) külön profilja van, ezért mindkettőben külön kell telepíteni.

Visszaállítás:
```powershell
Copy-Item "$PROFILE.bak" $PROFILE -Force
```
Ha korábban nem volt profilod: `Remove-Item $PROFILE`.

## Kipróbálás telepítés nélkül

**Bash:**
```bash
source ./bashrc
```

**PowerShell** (a sor elején álló pont és szóköz kell):
```powershell
Set-ExecutionPolicy -Scope Process Bypass; . .\profile.ps1
```

A változás csak az aktuális ablakra vonatkozik, bezárás után minden visszaáll.
