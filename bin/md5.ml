open Core

(* MD5 is a hash function that takes an input of any length and produces a fixed-length output, known as a hash value or message digest. *)

(* md5sum is a command-line utility in Unix-like operating systems that implements the MD5 algorithm. *)

let do_hash file =
  Md5.digest_file_blocking file |> Md5.to_hex |> print_endline

let filename_param =
  let open Command.Param in
  anon ("filename" %: string)

let command =
  Command.basic
    ~summary: "Generate an MD5 hash of the input data lol"
    ~readme:(fun () -> "This program generates an MD5 hash, which is a unique digital fingerprint, for any given file. Use it to quickly check if a file has been changed or to confirm its authenticity.")
    (Command.Param.map filename_param ~f:(fun filename () ->
       do_hash filename))

let () =
  Command_unix.run
    ~version:"1.0"
    ~build_info:"RWO"
    command
