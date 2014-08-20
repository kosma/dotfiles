# OpenOCD & STM32F10x support

define stm32
    set remote hardware-breakpoint-limit 6
    set remote hardware-watchpoint-limit 4
    target extended :4242
end

define erase
    monitor stm32f1x mass_erase 0
end

define flash
    monitor reset halt
    monitor flash write_image erase $arg0 $arg1
end

define halt
    monitor reset halt
end

# DBGMCU_CR bits: DBG_SLEEP, DBG_STOP

define dbgsleep1
    monitor mww 0xE0042004 0x00000001
end

define dbgsleep0
    monitor mww 0xE0042004 0x00000000
end

# NuttX errno access
define errno
    print strerror(*get_errno_ptr())
end

define go
    make
    load
    run
end

# generic stuff

set height 0
set confirm off

set history save on
set history filename ~/.gdb_history
set history size 1000

source ~/.gdbinit.local

# vim: set ts=4 sw=4 et:
