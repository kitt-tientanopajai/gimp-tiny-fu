;; kitty.in.th-photo-frame.scm
;; v. 0.14
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005-2008 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script scans for min/max of RGB then span the channels to the maximum.
;;
;; ChangeLogs
;; v0.14 - Mon, 15 Dec 2008 22:40:12 +0700
;; - Move to Filters menu
;;
;; v0.13 - Sat, 24 Nov 2007 20:11:33 +0700
;; - Fixed text/frame layering
;;
;; v0.12 - Wed, 14 Nov 2007 00:00:00 +0700
;; - Port to GIMP 2.4

(define *position-def*
	'(("Top-Left" 0)
		("Top-Right" 1)
		("Bottom-Left" 2)
		("Bottom-Right" 3)))

(define (kitty.in.th-photo-frame image drawable frame-size frame-color frame-opaque text text-color font font-size position)
	(gimp-image-undo-group-start image)
	(let* (
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image)))
		(fg-color (car (gimp-context-get-foreground)))
		(bg-layer (car (gimp-image-get-active-layer image)))
		(frame-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE "kitty.in.th - frame layer" frame-opaque NORMAL-MODE)))
		(text-layer (car (gimp-text-fontname image -1 0 0 text 0 TRUE font-size 0 font)))
		(text-width (car (gimp-drawable-width text-layer)))
		(text-height (car (gimp-drawable-height text-layer)))
		(yoffset 0)
		(x 0)
		(y 0))


		(gimp-image-add-layer image frame-layer -1)
		(gimp-edit-clear frame-layer)
		(gimp-selection-all image)
		(gimp-selection-shrink image frame-size)
		(gimp-selection-invert image)
		(gimp-context-set-foreground frame-color)
		(gimp-edit-fill frame-layer 0)
		(gimp-selection-none image)

		(gimp-context-set-foreground text-color)

		(set! yoffset (- (/ (- frame-size text-height) 2) 0))

		(cond
			((= position 0)
				(set! x frame-size)
				(set! y yoffset))
			((= position 1)
				(set! x (- image-width (+ text-width frame-size)))
				(set! y yoffset))
			((= position 2)
				(set! x frame-size)
				(set! y (- image-height (+ (- frame-size yoffset) 1))))
			((= position 3)
				(set! x (- image-width  (+ text-width frame-size)))
				(set! y (- image-height (+ (- frame-size yoffset) 1)))))

		(gimp-layer-set-offsets text-layer x y)
		(gimp-image-raise-layer-to-top image text-layer)
		(gimp-layer-set-opacity text-layer 50)

		(gimp-context-set-foreground fg-color)
		(gimp-image-set-active-layer image bg-layer))

	(gimp-image-undo-group-end image)
	(gimp-displays-flush))

(script-fu-register
	"kitty.in.th-photo-frame"
	"<Image>/Filters/kitty.in.th/Photo Frame..."
	"Semi-transparent Photo frame v.0.14"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-ADJUSTMENT "Frame Size" '(18 10 100 1 2 0 0)
	SF-COLOR "Frame Color" '(255 255 255)
	SF-ADJUSTMENT "Frame Opaque" '(40 0 100 1 5 0 0)
	SF-VALUE "Text" "\"kitty.in.th\""
	SF-COLOR "Text Color" '(64 64 64)
	SF-FONT "Font" "Nimbus Roman No9 L, Italic"
	SF-ADJUSTMENT "Font Size" '(16 8 72 1 2 0 1)
	SF-OPTION	"Position:" (mapcar car *position-def*))
