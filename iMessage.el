
(defun get-buddies-names ()
  "apple script to get buddy names"
  (parse-blob
   (shell-command-to-string (format "osascript -e 'tell application %S to get name of buddies'"
                                    "Messages"))))
(defun get-service-buddy (buddy)
  "apples script to get the service of the buddy"
  (message
   (replace-regexp-in-string "\n\\'" "" 
                             (shell-command-to-string (format "osascript -e 'tell application %S to get name of service of buddy %S'"
                                                              "Messages"
                                                              buddy)))))

(defun send-buddy-message (buddy service)
  "send message to the buddy and their service"
  (shell-command-to-string (format "osascript -e 'tell application %S to send %S to buddy %S of service %S'"
                                   "Messages"
                                   (call-interactively 'get-message)
                                   buddy
                                   service)))

(defun get-message (msg)
  "Prompt user for the message"
  (interactive "MMessage to send: ")
  (message "%s" msg))


(defun parse-blob (blob)
  "Split the buddies returning list"
  (split-string blob ","))

(defun s-trim (s)
  "Remove whitespace at the beginning and end of S."
  (s-trim-left (s-trim-right s)))

(setq helm-source-message
      '((name . "iMessage")
        (candidates . get-buddies-names)
        (action . (lambda (candidate)
                    (send-buddy-message
                     (s-trim candidate)
                     (get-service-buddy
                      (s-trim candidate)))))))

      (helm :sources '(helm-source-message))




