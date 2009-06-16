;; kitty.in.th-auto-photo-frame.scm
;; v. 0.09
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005-2007 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script automatically generate a simple photo frame. It requires two 
;; additional scripts:
;;   - kitty.in.th-auto-levels.scm
;;   - kitty.in.th-photo-frame
;;
;; Note: this script is written to favor my preferences. So, it might not 
;; suit yours.
;;

(define *auto-level-def*
	'(("kitty.in.th (T = 1)" 0)
		("kitty.in.th (T = 2)" 1)
		("kitty.in.th (T = 5)" 2)
		("kitty.in.th (T = 10)" 3)
		("The GIMP" 4)
		("None" 255)))

(define *position-def*
	'(("Top-Left" 0)
		("Top-Right" 1)
		("Bottom-Left" 2)
		("Bottom-Right" 3)))

(define (kitty.in.th-auto-photo-frame image drawable auto-level frame-size frame-color frame-opaque text text-color font font-size position)
	(let* (
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image)))
		(new-width 0)
		(new-height 0)
		(fg-color (car (gimp-context-get-foreground)))
		(bg-layer (car (gimp-image-get-active-layer image))))

		(if (< image-width image-height)
			(begin
				(set! new-width 361)
				(set! new-height 544))
			(begin
				(set! new-width 544)
				(set! new-height 361)))

		(gimp-image-scale image new-width new-height)
		(cond
			((= auto-level 0)
				(kitty.in.th-auto-levels image drawable 1 2))
			((= auto-level 1)
				(kitty.in.th-auto-levels image drawable 2 2))
			((= auto-level 2)
				(kitty.in.th-auto-levels image drawable 5 2))
			((= auto-level 3)
				(kitty.in.th-auto-levels image drawable 10 2))
			((= auto-level 4)
				(gimp-levels-auto drawable)))
		
		(kitty.in.th-photo-frame image drawable frame-size frame-color frame-opaque text text-color font font-size position)))

(script-fu-register
	"kitty.in.th-auto-photo-frame"
	"<Image>/Script-Fu/kitty.in.th/Auto Photo Frame..."
	"Automatic photo frame for kitty.in.th gallery v.0.09"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2007 Kitt Tientanopajai"
	"November 14, 2007"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-OPTION	"Auto Level Method:" (mapcar car *auto-level-def*)
	SF-ADJUSTMENT "Frame Size" '(18 10 100 1 2 0 0)
	SF-COLOR "Frame Color" '(255 255 255)
	SF-ADJUSTMENT "Frame Opaque" '(40 0 100 1 5 0 0)
	SF-VALUE "Text" "\"kitty.in.th\""
	SF-COLOR "Text Color" '(64 64 64)
	SF-FONT "Font" "Nimbus Roman No9 L, Italic"
	SF-ADJUSTMENT "Font Size" '(16 8 72 1 2 0 1)
	SF-OPTION	"Position:" (mapcar car *position-def*))
