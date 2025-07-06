open Core

(* MD5 is a hash function that takes an input of any length and produces a fixed-length output, known as a hash value or message digest. *)

(* md5sum is a command-line utility in Unix-like operating systems that implements the MD5 algorithm. *)

let do_hash hash_length filename =
  Md5.digest_file_blocking filename
  |> Md5.to_hex
  |> (fun s -> String.prefix s hash_length)
  |> print_endline

let command =
  Command.basic
    ~summary: "Generate an MD5 hash of the input data lol"
    ~readme:(fun () -> "This program generates an MD5 hash, which is a unique digital fingerprint, for any given file.
                        Use it to quickly check if a file has been changed or to confirm its authenticity.")
    (let%map_open.Command hash_length = anon ("hash_length" %: int)
     and filename = anon ("filename" %: string) in
     fun () -> do_hash hash_length filename)

let () =
  Command_unix.run ~version:"1.0" ~build_info:"RWO" command
