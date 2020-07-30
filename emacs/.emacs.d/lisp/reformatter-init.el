(use-package reformatter
  :defer t)

(defcustom prettier-format-command "prettier"
  "Command used for reformatting.
This command should receive SQL input via STDIN and output the
reformatted SQL to STDOUT, returning an appropriate exit code."
  :type 'string)

(reformatter-define prettier-format
  :program prettier-format-command
  :args '("--stdin")
  :lighter " EsLFmt")


(provide 'reformatter-init)
