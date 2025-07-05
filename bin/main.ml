open Core

let do_hash file =
  Md5.digest_file_blocking file |> Md5.to_hex |> print_endline

let () =
  do_hash "/home/alex/.spacemacs"
