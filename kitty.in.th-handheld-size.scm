;; kitty.in.th-handheld-size.scm
;; v. 0.06
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005-2007 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script resizes an image to approriate size for handheld devices.
;;
;; ChangeLogs
;; v 0.05 - Mon, 15 Dec 2008 22:39:23 +0700
;; - Move to Filters menu

(define *size-def* 
	'(("VGA (640x480)" 0)
		("Hi-Res+ (320x480)" 1)
		("Hi-Res (320x320)" 2)
		("QVGA (320x240)" 3)
		("Lo-Res (160x160)" 4)))

(define (kitty.in.th-handheld-size image drawable size)
	(let* (
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image)))
		(aspect-ratio (/ image-width image-height))
		(new-width 0)
		(new-height 0))

		(gimp-image-undo-group-start image)
		(cond
			((= size 0)
				(if (< image-width image-height)
					(begin
						(set! new-width 480)
						(set! new-height (/ new-width aspect-ratio)))
					(begin
						(set! new-height 480)
						(set! new-width (* new-height aspect-ratio)))))
			((= size 1)
				(if (< image-width image-height)
					(begin
						(set! new-width 320)
						(set! new-height (/ new-width aspect-ratio)))
					(begin
						(set! new-height 320)
						(set! new-width (* new-height aspect-ratio)))))
			((= size 2)
				(if (< image-width image-height)
					(begin
						(set! new-width 320)
						(set! new-height (/ new-width aspect-ratio)))
					(begin
						(set! new-height 320)
						(set! new-width (* new-height aspect-ratio)))))
			((= size 3)
				(if (< image-width image-height)
					(begin
						(set! new-width 240)
						(set! new-height (/ new-width aspect-ratio)))
					(begin
						(set! new-height 240)
						(set! new-width (* new-height aspect-ratio)))))
			((= size 4)
				(if (< image-width image-height)
					(begin
						(set! new-width 160)
						(set! new-height (/ new-width aspect-ratio)))
					(begin
						(set! new-height 160)
						(set! new-width (* new-height aspect-ratio))))))
				
		(gimp-image-scale image new-width new-height)
		(gimp-image-undo-group-end image)))

(script-fu-register
	"kitty.in.th-handheld-size"
	"<Image>/Filters/kitty.in.th/Handheld size..."
	"Resize image to the resolution of handheld devices v.0.05"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-OPTION	"Size:" (mapcar car *size-def*))
