open Core

(* MD5 is a hash function that takes an input of any length and produces a fixed-length output, known as a hash value or message digest. *)

(* md5sum is a command-line utility in Unix-like operating systems that implements the MD5 algorithm. *)

let do_hash file =
  Md5.digest_file_blocking file |> Md5.to_hex |> print_endline

let regular_file =
  Command.Arg_type.create (fun filename ->
    match Sys_unix.is_file filename with
      | `Yes -> filename
      | `No -> failwith "Not a regular file"
      | `Unknown ->
        failwith "Could not determine if this was a regular file")

let command =
  Command.basic
    ~summary: "Generate an MD5 hash of the input data lol"
    ~readme:(fun () -> "This program generates an MD5 hash, which is a unique digital fingerprint, for any given file.
                        Use it to quickly check if a file has been changed or to confirm its authenticity.")
    (let%map_open.Command filename =
       anon ("filename" %: regular_file)
     in
     fun () -> do_hash filename)

let () =
  Command_unix.run ~version:"1.0" ~build_info:"RWO" command
