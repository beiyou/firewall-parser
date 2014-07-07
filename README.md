## Firewall::Parser - Firewall Configuration Parser

### TODO

1. **finished** write a filter of vens
2. **finished** write a grammar of vens
3. **finished** desgin the object format
4. **finished** write a simple parser that can use grammar to parse out result
5. store parse info to database

### FURTURE

1. precompile grammar module (this works)
2. write objects to db (a save subroutine in Firewall::Object)
3. **finished** chinese support

### LOG INFO

    Begin parsing: VENS/10.109.32.168
    Load package ... OK
    ...
    OBJECT/address venus: 10.109.32.166~10.109.32.255 192.168.1.101
    GROUPS/service ...
    POLICY....
    ....
    Compelte. Total 0.20 sec

### OBJECT SYMBOL

    OBJECT : (TYPE,) STRING, VALUE

    TYPE : ADDRESS | SERVICE | ADDRESS_GROUP | SERVICE_GROUP 
           | SCHEDULE | INTERFACE

    INSERT INTO (tablename) (fields) VALUES (values)

    Save As Array Reference

    POLICY : ACTION, SRC_IF, DST_IF, SRC_IP, DST_IP, SERVICE, SCHEDULE, 
             STATUS

    Save As Array Reference

