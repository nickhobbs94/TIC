meta:
  id: bytes_with_io
  title: TIC
  endian: le
  encoding: ascii
doc: |
   isagraf
seq:
  - id: main
    type: maintable
instances:
  defappli:
    pos: main.defappli
    type: defappli
  defprod:
    pos: main.defprod
    type: defprod
  defusf:
    pos: main.defusf
    type: defusf
  deffbl:
    pos: main.deffbl
    type: deffbl
  deftcnv:
    pos: main.deftcnv
    type: deftcnv
  defhie:
    pos: main.defhie
    type: defhie
  defoem:
    pos: main.defoem
    type: defoem
  defprog:
    pos: main.defprog
    type: defprog
    size: 4*(defhie.num_begin+defhie.num_end+defhie.num_sfc_main+defhie.num_sfc_child)
  codeprog:
    pos: main.codeprog
    type: codeprog
    size: 4*(defhie.num_begin+defhie.num_end+defhie.num_sfc_main+defhie.num_sfc_child)
  progname_code:
    pos: codeprog.address_of_prog[0]
    type: progname_code
    repeat: expr
    repeat-expr: 1
  linksfc:
    pos: main.linksfc
    type: linksfc
    size: 4*(defhie.num_begin+defhie.num_end+defhie.num_sfc_main+defhie.num_sfc_child)
  codevar:
    pos: main.codevar
    type: codevar
  initboo:
    pos: codevar.addr_init_bool
    type: initboo(codevar.num_bools_init)
  backup:
    pos: codevar.addr_backup
    type: backup
types:
  maintable:
    seq:
      - id: data
        type: u4
        doc: Indicator of processor validity
      - id: defprod
        type: u4
        doc: Addr of definition table of the product
      - id: defappli
        type: u4
        doc: Addr of application definition table
      - id: defusf
        type: u4
        doc: Addr of user functions
      - id: deffbl
        type: u4
        doc: Addr of function blocks
      - id: deffcnv
        type: u4
        doc: Addr of conversion functions
      - id: deftcnv
        type: u4
        doc: Addr of conversion tables
      - id: defvar
        type: u4
        doc: Addr of variables
      - id: codevar
        type: u4
        doc: Addr of boards def
      - id: defoem
        type: u4
        doc: Addr of coding table OEM
      - id: codeoem
        type: u4
        doc: Addr of coding variables
      - id: defhie
        type: u4
        doc: Addr of hierarchy project def
      - id: defprog
        type: u4
        doc: Addr of def programs
      - id: codeprog
        type: u4
        doc: Addr of coding table of programs
      - id: linksfc
        type: u4
        doc: Addr of structure SFCs table
      - id: resource
        type: u4
        doc: Addr of resources table
  defappli:
    seq:
      - id: projname
        type: str
        size: 16
      - id: gendate
        type: u4
      - id: checksum
        type: u4
      - id: appversion
        type: u2
      - id: numerror
        type: u2
      - id: startmode
        type: u2
      - id: cycletime
        type: u2
      - id: appsize
        type: u4
  defprod:
    seq:
      - id: targetname
        type: str
        size: 16
      - id: targetversion
        type: str
        size: 8
  defusf:
    seq:
      - id: numuserfunc
        type: u2
      - id: reserved
        type: u2
      - id: function_description
        type: funcdef
        repeat: expr
        repeat-expr: numuserfunc
    types:
      funcdef:
        seq:
          - id: function_number
            type: u2
          - id: function_name
            type: str
            size: 9
          - id: terminator
            type: u1
  deffbl:
    seq:
      - id: num_function_block
        type: u2
      - id: reserved
        type: u2
      - id: functionblock_description
        type: fbdesc
        repeat: expr
        repeat-expr: num_function_block
    types:
      fbdesc:
        seq:
          - id: fbnum
            type: u2
          - id: num_instance
            type: u2
          - id: fb_name
            type: str
            size: 10
          - id: terminator
            contents: [0x00, 0x00]
  deffcnv:
    params:
      - id: n
        type: u4
    seq:
      - id: num_conv_functions
        type: u2
      - id: reserved
        type: u2
      - id: conversion_function_description
        type: conversion_function_description
        repeat: expr
        repeat-expr: n
    types:
      conversion_function_description:
        seq: 
          - id: cf_number
            type: u2
          - id: reserved
            type: u2
          - id: cf_name
            type: str
            size: 10
          - id: terminator
            type: u2
  deftcnv: {}
  defvar:
    seq:
      - id: num_internal_bool
        type: u2
      - id: num_input_bool
        type: u2
      - id: num_output_bool
        type: u2
      - id: reserved1
        type: u2
      - id: num_internal_analog
        type: u2
      - id: num_input_analog
        type: u2
      - id: num_output_analog
        type: u2
      - id: reserved2
        type: u2
      - id: num_timer
        type: u2
      - id: reserved3
        type: u2
      - id: reserved4
        type: u2
      - id: reserved5
        type: u2
      - id: num_internal_msg
        type: u2
      - id: num_input_msg
        type: u2
      - id: num_output_msg
        type: u2
      - id: reserved6
        type: u2
  codevar:
    seq:
      - id: addr_init_bool
        type: u4
      - id: addr_init_analog
        type: u4
      - id: addr_init_timer
        type: u4 
      - id: addr_init_msg
        type: u4
      - id: addr_length_msg_table
        type: u4
      - id: addr_modbus_def
        type: u4
      - id: addr_backup
        type: u4
      - id: num_bools_init
        type: u2
      - id: num_analogs_init
        type: u2
      - id: num_timer_init
        type: u2
      - id: num_msg_init
        type: u2
  initboo:
    params:
      - id: n
        type: u4
    seq:
      - id: var_number
        doc: boolean variable number to be set to true on startup
        type: u2
        repeat: expr
        repeat-expr: n
      - id: terminator
        type: u1
        repeat: expr
        repeat-expr: 4 - ((n * 2)%4)
  initana:
    params:
      - id: n
        type: u4
    seq:
      - id: var
        type: ana_init
        repeat: expr
        repeat-expr: n
      - id: terminator
        type: u1
        repeat: expr
        repeat-expr: 4 - ((n * 6)%4)
    types:
      ana_init:
        seq:
          - id: var_number
            type: u2
          - id: value
            type: u4
  inittmr:
    params:
      - id: n
        type: u4
    seq:
      - id: var
        type: tmr_init
        repeat: expr
        repeat-expr: n
      - id: terminator
        type: u1
        repeat: expr
        repeat-expr: 4 - ((n * 6)%4)
    types:
      tmr_init:
        seq:
          - id: var_number
            type: u2
          - id: value
            type: u4
  initmsg:
    params:
      - id: n
        type: u4
    seq:
      - id: var
        type: msg_init
        repeat: expr
        repeat-expr: n
      - id: terminator
        type: u1
        repeat: expr
        repeat-expr: 0 #TODO
    types:
      msg_init:
        seq:
          - id: var_number
            type: u2
          - id: len
            type: u1
          - id: string
            type: str
            size: len
  lngmsg: {}
  defmodbus: {}
  defmdbboo: {}
  defmdbana: {}
  defmdbtmr: {}
  defmdbmsg: {}
  backup:
    seq:
      - id: memory_area
        size: 64
      - id: num_bool
        type: u2
      - id: first_bool
        type: u2
      - id: num_analog
        type: u2
      - id: first_analog
        type: u2
      - id: num_timers
        type: u2
      - id: first_timer
        type: u2
      - id: num_msg
        type: u2
      - id: first_msg
        type: u2
  defoem: 
    seq:
      - id: num_inputs_board
        type: u2
      - id: num_outputs_board
        type: u2
      - id: num_analog_vars
        type: u2
      - id: reserved
        type: u2
  codeoem: {}
  defboo:
    seq:
      - id: boo_var
        type: boo_var
        repeat: expr
        repeat-expr: 1 # TODO
    types:
      boo_var:
        seq:
          - id: number
            type: u2
          - id: rack
            type: u1
          - id: slot
            type: u1
          - id: channel
            type: u1
          - id: io
            type: u1
          - id: conversion_length
            type: u1
          - id: real
            type: u1
  defana: {}
  defmsg: {}
  defbrd: {}
  defhie:
    seq:
      - id: num_begin
        type: u2
      - id: num_end
        type: u2
      - id: num_sfc_main
        type: u2
      - id: num_sfc_child
        type: u2
      - id: reserved
        type: u2
      - id: sfc_descriptions
        type: sfc_description
        repeat: expr
        repeat-expr: num_sfc_main + num_sfc_child
      - id: terminator
        contents: [0x00, 0x00, 0x00, 0x00]
    types:
      sfc_description:
        seq:
          - id: sfc_number
            type: u2
          - id: level
            type: u2
  defprog: 
    seq:
      - id: programs
        type: program_desc
        repeat: eos
    types:
      program_desc:
        seq:
          - id: program_type
            type: u2
          - id: level
            type: u2
  codeprog:
    seq:
      - id: address_of_prog
        type: u4
        repeat: eos
  progname_code:
    seq:
      - id: begin_action_addr
        type: u2
      - id: s1
        doc: size block s1
        type: u2
      - id: complex_action_addr
        type: u2
      - id: s2
        doc: size block s2
        type: u2
      - id: end_action_addr
        type: u2
      - id: s3
        doc: size block s3
        type: u2
    instances:
      begin:
        size: s1
        pos: begin_action_addr + _parent.codeprog.address_of_prog[0]
  linksfc:
    seq:
      - id: addr_program_structure
        type: u4
        repeat: eos
  progname_link: {}
  resource:
    seq:
      - id: num_resources
        type: u4
      - id: resource_instance
        type: resource_instance
        repeat: expr
        repeat-expr: num_resources
    types:
      resource_instance:
        seq:
          - id: name
            type: str
            size: 16
          - id: type
            type: u4
          - id: data_size
            type: u4
          - id: addr_data
            type: u4
          - id: addr_path
            type: u4


#io: _root._io