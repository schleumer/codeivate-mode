;;; codeivate-mode.el --- Example of IPC using TCP sockets
;;; Commentary:
;;; Ok
;; Author: Aurélien Aptel <aurelien.aptel@gmail.com>

;;; Code:

(defvar codeivate-port 13666)
(defvar codeivate-proc
  (open-network-stream "codeivated-transport" (current-buffer) "localhost" codeivate-port))

(defvar codeivate-state (make-hash-table :test 'equal))

(defun codeivate-process-key-press ()
  "Ok."
  ;;; only triggger when it's a file, not on all Emacs's buffers
  (let (file)
    (setq file (buffer-file-name (current-buffer)))
    (when file
      (let (current-mode state)
        (setq current-mode (format "%s" major-mode))
        (setq state (+ (gethash current-mode codeivate-state 0) 1))
        (puthash current-mode state codeivate-state)
        (message "%s" (gethash current-mode codeivate-state))))))

(defun codeivate-mode ()
  "Do a barrel roll."
  (add-hook 'post-self-insert-hook #'codeivate-process-key-press))

(provide 'codeivate-mode)
;;; codeivate-mode.el ends here
