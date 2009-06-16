;; kitty.in.th-cross-process.scm
;; v. 0.01
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2009 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; Cross Processing
;;
;; ChangeLogs
;; v0.01 - Sun, 08 Feb 2009 19:04:56 +0700
;; - Initial release

(define (kitty.in.th-cross image drawable)
	(let* (
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image)))
		(cross-layer (car (gimp-layer-new-from-drawable drawable image)))
		(cast-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE "kitty.in.th - cast" 15 COLOR)))
		(fg-color (car (gimp-context-get-foreground))))

		(gimp-image-undo-group-start image)

		(gimp-layer-set-name cross-layer "kitty.in.th - cross")
		(gimp-image-add-layer image cross-layer -1)
		(gimp-image-add-layer image cast-layer -1)
		(gimp-curves-spline cross-layer HISTOGRAM-VALUE 8 (vector 0 0 64 60 192 196 255 255))
		(gimp-curves-spline cross-layer HISTOGRAM-RED 10 (vector 0 0 84 48 148 192 192 254 255 255))
		(gimp-curves-spline cross-layer HISTOGRAM-GREEN 10 (vector 0 0 64 92 148 208 188 248 255 255))
		(gimp-curves-spline cross-layer HISTOGRAM-BLUE 4 (vector 0 36 255 208))
		
		(gimp-context-set-foreground '(225 255 0))
		(gimp-drawable-fill cast-layer FOREGROUND-FILL)

		(gimp-context-set-foreground fg-color)
		(gimp-displays-flush)
		(gimp-image-undo-group-end image)))

(script-fu-register
	"kitty.in.th-cross-process"
	"<Image>/Filters/kitty.in.th/Cross Processing"
	"kitty.in.th cross processing effect v.0.01"
	"Kitt Tientanopajai"
	"Copyright (C) 2009 Kitt Tientanopajai"
	"February 8, 2009"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0)
