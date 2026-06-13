# Unifly Configuration Options

These options are available when configuring Home Manager settings under:
`programs.unifly.settings`

They translate to the local TOML configuration file: `~/.config/unifly/config.toml`

## programs\.unifly\.settings

Configuration written to ` ~/.config/unifly/config.toml `\.
See [https://hyperb1iss\.github\.io/unifly/guide/configuration/](https://hyperb1iss\.github\.io/unifly/guide/configuration/) for settings\.



*Type:*
open submodule of (TOML value)



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  default_profile = "default";
  defaults = {
    output = "table";
    theme = "silkcircuit-neon";
  };
  profiles = {
    default = {
      controller = "https://192.168.1.1";
      site = "default";
      auth_mode = "session";
      username = "admin";
    };
  };
}

```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.default_profile



Default profile name\.



*Type:*
null or string



*Default:*

```nix
"default"
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.defaults



Global default settings\.



*Type:*
submodule



*Default:*

```nix
{ }
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.defaults\.chart_quality



TUI chart glyph quality\.



*Type:*
null or one of “block”, “braille”, “octant”



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.defaults\.color



Color output mode\.



*Type:*
one of “auto”, “always”, “never”



*Default:*

```nix
"auto"
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.defaults\.effects



Whether tachyonfx animations are enabled in the TUI\.



*Type:*
boolean



*Default:*

```nix
true
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.defaults\.insecure



Global default for insecure TLS verification\.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.defaults\.output



Default output format\.



*Type:*
one of “table”, “json”, “yaml”, “csv”



*Default:*

```nix
"table"
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.defaults\.show_donate



Whether to show the donate button in the TUI status bar\.



*Type:*
boolean



*Default:*

```nix
true
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.defaults\.theme



Theme name for the TUI (e\.g\., ‘nord’, ‘dracula’, ‘silkcircuit-neon’)\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.defaults\.timeout



Global connection timeout in seconds\.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
30
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.demo



Demo mode settings for PII sanitization in TUI/recordings\.



*Type:*
submodule



*Default:*

```nix
{ }
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.demo\.enabled



Enable demo mode PII sanitization\.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.demo\.keep_names



Names to keep visible even if they’d otherwise match a redact pattern\.



*Type:*
list of string



*Default:*

```nix
[ ]
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.demo\.redact_isp



Replace ISP name and upstream DNS in health data\.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.demo\.redact_macs



Replace MAC addresses with locally-administered fakes\.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.demo\.redact_names



Names to redact (case-insensitive substring match across all text)\.



*Type:*
list of string



*Default:*

```nix
[ ]
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.demo\.redact_ssids



Replace WiFi SSID names with generic alternatives\.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.demo\.redact_wan_ips



Replace public/WAN IP addresses with RFC 5737 documentation IPs\.



*Type:*
boolean



*Default:*

```nix
true
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.demo\.seed



Fixed seed for deterministic replacements across sessions\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles



Named controller profiles\.



*Type:*
attribute set of (submodule)



*Default:*

```nix
{ }
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.api_key



API key (plaintext — prefer keyring or env var)\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.api_key_env



Environment variable name containing the API key\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.auth_mode



Authentication mode: integration (API key), session (username/password), hybrid, or cloud\.



*Type:*
one of “integration”, “session”, “hybrid”, “cloud”



*Default:*

```nix
"integration"
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.ca_cert



Path to custom CA certificate\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.controller



Controller base URL (e\.g\., ‘https://192\.168\.1\.1’)\.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.host_id



Host/console ID for cloud connector mode\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.host_id_env



Environment variable name containing the host/console ID\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.insecure



Override insecure TLS setting\.



*Type:*
null or boolean



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.password



Password for session auth (plaintext — prefer keyring)\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.site



Site name or UUID\.



*Type:*
string



*Default:*

```nix
"default"
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.timeout



Override connection timeout in seconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.totp_env



Environment variable name containing a TOTP token for MFA\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()



## programs\.unifly\.settings\.profiles\.\<name>\.username



Username for session auth\.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [/nix/store/2lk0v7q5xbzydryzizlgsbbxi8b3358y-source/modules/home-manager\.nix]()
