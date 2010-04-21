;; kitty.in.th-save-jpeg.scm
;; v. 0.01
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2010 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script is a quick save file in JPEG format to predefined location.
;;
;; ChangeLogs
;; v0.01 Wed, 21 Apr 2010 15:48:58 +0700
;;   - Initial Release

(define (kitty.in.th-save-jpeg image drawable)
	(let* (
		(filename (string-append (car (strbreakup (car (gimp-image-get-filename image)) ".")) ".jpg"))
	)

	(file-jpeg-save RUN-NONINTERACTIVE image drawable filename filename 0.85 0 1 1 "" 2 1 0 2)))

(script-fu-register
	"kitty.in.th-save-jpeg"
	"<Image>/File/Save/Quick Save to JPEG"
	"kitty.in.th Quick Save to JPEG v.0.01"
	"Kitt Tientanopajai"
	"Copyright (C) 2010 Kitt Tientanopajai"
	"April 21, 2010"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0)
