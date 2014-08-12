(* Ocsigen
 * Copyright (C) 2005 Vincent Balat
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, with linking exception;
 * either version 2.1 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*)

(** Writing messages in the logs *)


(** Write a message in access.log *)
val accesslog : string -> unit

(** Write a message in errors.log *)
val errlog : ?section:Lwt_log.section -> string -> unit

(** Write a message in warnings.log *)
val warning : ?section:Lwt_log.section -> string -> unit

(** Write a message in the console (if not called in silent mode) *)
val console : (unit -> string) -> unit

(** Use that function for all impossible cases in exception handlers
    ([try ... with ... | e -> unexpected_exception ...] or [Lwt.catch ...]).
    A message will be written in [warnings.log].
    Put something in the string to help locating the problem (usually the name
    of the function where is has been called).
*)
val unexpected_exception : exn -> string -> unit

(** Path to the error log file *)
val error_log_path : unit -> string


(** Register sections (so as to be able to dynamically change their level)
    Level change is obtain by piping `logs: <section_name> <level_name>` to the
    Ocsigen command-pipe. Parameter <section_name> must be the name of a
    registered section (or else nothing happens), and <level_name> must be one
    of `Debug`, `Info`, `Notice`, `Warning`, `Error`, `Fatal` (or else the
    default level is restored)
*)
val register_section: Lwt_log.section -> unit

(**/**)

val open_files : ?user:string option -> ?group:string option -> unit -> unit Lwt.t
val command_f : exn -> string -> string list -> unit Lwt.t
